import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/base_screen/base_controller.dart';
import '../../model/request/dashboard_request.dart';
import '../../model/request/product_list_request.dart';
import '../../model/response/dashboard_response.dart';
import '../../model/usecase/product/dashboard_usecase.dart';
import '../../model/usecase/product/product_list_usecase.dart';

/// Controller for home screen managing categories, subcategories and pagination
class HomeController extends BaseController {
  final DashboardUseCase _dashboardUseCase;
  final ProductListUseCase _productListUseCase;

  HomeController(this._dashboardUseCase, this._productListUseCase);

  // Main categories data from initial API call
  var allCategories = <CategoryModel>[].obs;
  var selectedCategoryIndex = 1.obs;

  // Paginated data for selected category
  var categoryData = <CategoryModel>[].obs;
  var currentPageIndex = 1.obs;
  var isLoadingMore = false.obs;
  var hasMoreData = true.obs;

  // Horizontal pagination for subcategories
  var subcategoryPaginationData = <int, SubcategoryPaginationState>{}.obs;
  var subcategoryLoadingStates = <int, bool>{}.obs;

  @override
  void init() {
    super.init();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getDashboardData();
    });
  }

  /// Fetch initial dashboard data with all categories
  Future<bool> getDashboardData() async {
    setLoading(true);

    final request = DashboardRequest(categoryId: 0, pageIndex: 1);

    final result = await _dashboardUseCase.call(request);

    return result.fold(
      (response) {
        setLoading(false);
        if (response.status == 200) {
          allCategories.value = response.result.categories;
          // Auto-select first category after data loads
          if (allCategories.isNotEmpty) {
            Future.delayed(const Duration(milliseconds: 500), () {
              selectCategory(1);
            });
          }
        }
        return true;
      },
      (failure) {
        setLoading(false);
        Get.rawSnackbar(message: failure.message ?? 'Something went wrong');
        return false;
      },
    );
  }

  /// Handle category selection and reset pagination state
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    // Reset pagination state for new category
    currentPageIndex.value = 1;
    hasMoreData.value = true;
    categoryData.clear();

    if (allCategories.isNotEmpty && index < allCategories.length) {
      getCategorySpecificData(allCategories[index].id);
    }
  }

  /// Get all available categories
  List<CategoryModel> get categories => allCategories.value;

  /// Get subcategories for currently selected category
  List<SubCategoryModel> getCurrentSubcategories() {
    if (allCategories.isEmpty || selectedCategoryIndex.value >= allCategories.length) {
      return [];
    }
    return allCategories[selectedCategoryIndex.value].subCategories ?? [];
  }

  /// Get name of currently selected category
  String getCurrentCategoryName() {
    if (allCategories.isEmpty || selectedCategoryIndex.value >= allCategories.length) {
      return '';
    }
    return allCategories[selectedCategoryIndex.value].name;
  }

  /// Get list of all category names for tab bar
  List<String> getCategoryNames() {
    return allCategories.map((category) => category.name).toList();
  }

  /// Fetch category-specific data with pagination support
  Future<bool> getCategorySpecificData(int categoryId, {bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadingMore.value || !hasMoreData.value) return false;
      isLoadingMore.value = true;
    } else {
      setLoading(true);
    }

    final request = DashboardRequest(categoryId: categoryId, pageIndex: currentPageIndex.value);

    final result = await _dashboardUseCase.call(request);

    return result.fold(
      (response) {
        if (loadMore) {
          isLoadingMore.value = false;
        } else {
          setLoading(false);
        }

        if (response.status == 200) {
          if (loadMore) {
            // Determine if more data is available for pagination
            bool hasSubcategories =
                response.result.categories.isNotEmpty &&
                response.result.categories.any(
                  (category) =>
                      category.subCategories != null && category.subCategories!.isNotEmpty,
                );

            if (hasSubcategories) {
              // Append new page data to existing list
              categoryData.addAll(response.result.categories);
              currentPageIndex.value++;
            } else {
              // End of data reached
              hasMoreData.value = false;
            }
          } else {
            // Initial load - replace all data
            categoryData.value = response.result.categories;

            // Check if pagination is possible
            bool hasSubcategories =
                response.result.categories.isNotEmpty &&
                response.result.categories.any(
                  (category) =>
                      category.subCategories != null && category.subCategories!.isNotEmpty,
                );

            if (hasSubcategories) {
              currentPageIndex.value = 2; // Prepare for next page
              hasMoreData.value = true;
            } else {
              hasMoreData.value = false;
            }
          }
        }
        return true;
      },
      (failure) {
        if (loadMore) {
          isLoadingMore.value = false;
        } else {
          setLoading(false);
        }
        Get.rawSnackbar(message: failure.message ?? 'Something went wrong');
        return false;
      },
    );
  }

  /// Trigger loading more data when user scrolls to bottom
  void loadMoreCategoryData() {
    if (allCategories.isNotEmpty && selectedCategoryIndex.value < allCategories.length) {
      getCategorySpecificData(allCategories[selectedCategoryIndex.value].id, loadMore: true);
    }
  }

  /// Get all loaded category data (includes pagination)
  List<CategoryModel> get currentCategoryData => categoryData.value;

  /// Get all subcategories from paginated category data
  List<SubCategoryModel> getCurrentCategorySubcategories() {
    List<SubCategoryModel> allSubcategories = [];
    for (CategoryModel category in categoryData) {
      if (category.subCategories != null && category.subCategories!.isNotEmpty) {
        allSubcategories.addAll(category.subCategories!);
      }
    }
    return allSubcategories;
  }

  /// Check if selected category has any data to display
  bool get hasCurrentCategoryData {
    return getCurrentCategorySubcategories().isNotEmpty;
  }

  /// Calculate total products across all loaded subcategories
  int get totalProductCount {
    int count = 0;
    for (SubCategoryModel subcategory in getCurrentCategorySubcategories()) {
      count += subcategory.products.length;
    }
    return count;
  }

  /// Load more products for a specific subcategory (horizontal pagination)
  Future<void> loadMoreProductsForSubcategory(int subcategoryId) async {
    if (subcategoryLoadingStates[subcategoryId] == true) return;

    subcategoryLoadingStates[subcategoryId] = true;

    final currentState =
        subcategoryPaginationData[subcategoryId] ??
        SubcategoryPaginationState(subcategoryId: subcategoryId);

    final request = ProductListRequest(
      pageIndex: currentState.currentPage + 1,
      subCategoryId: subcategoryId,
    );

    final result = await _productListUseCase.call(request);

    result.fold(
      (response) {
        if (response.status == 200 && response.result.isNotEmpty) {
          final newProducts =
              response.result
                  .map(
                    (item) => ProductModel(
                      id: item.id,
                      name: item.name,
                      priceCode: item.priceCode,
                      imageName: item.imageName,
                    ),
                  )
                  .toList();

          final updatedState = SubcategoryPaginationState(
            subcategoryId: subcategoryId,
            products: [...currentState.products, ...newProducts],
            currentPage: currentState.currentPage + 1,
            hasMoreData: response.result.length >= 10, // Assuming 10 items per page
          );

          subcategoryPaginationData[subcategoryId] = updatedState;
        } else {
          // No more data
          final updatedState = currentState.copyWith(hasMoreData: false);
          subcategoryPaginationData[subcategoryId] = updatedState;
        }
      },
      (failure) {
        Get.rawSnackbar(message: failure.message ?? 'Failed to load more products');
      },
    );

    subcategoryLoadingStates[subcategoryId] = false;
  }

  /// Get paginated products for a subcategory
  List<ProductModel> getProductsForSubcategory(int subcategoryId) {
    final state = subcategoryPaginationData[subcategoryId];
    if (state != null && state.products.isNotEmpty) {
      return state.products;
    }

    // Return original products from subcategory if no pagination data exists
    for (final category in categoryData) {
      if (category.subCategories != null) {
        for (final subcategory in category.subCategories!) {
          if (subcategory.id == subcategoryId) {
            return subcategory.products;
          }
        }
      }
    }
    return [];
  }

  /// Check if subcategory has more data for horizontal pagination
  bool hasMoreProductsForSubcategory(int subcategoryId) {
    final state = subcategoryPaginationData[subcategoryId];
    return state?.hasMoreData ?? true;
  }

  /// Check if subcategory is loading more products
  bool isLoadingMoreProductsForSubcategory(int subcategoryId) {
    return subcategoryLoadingStates[subcategoryId] ?? false;
  }

  /// Initialize pagination data for a subcategory
  void initializeSubcategoryPagination(int subcategoryId, List<ProductModel> initialProducts) {
    if (!subcategoryPaginationData.containsKey(subcategoryId)) {
      subcategoryPaginationData[subcategoryId] = SubcategoryPaginationState(
        subcategoryId: subcategoryId,
        products: initialProducts,
        currentPage: 1,
        hasMoreData: initialProducts.length >= 5, // Assuming initial load is page 1 with 10 items
      );
    }
  }
}

/// State class to manage horizontal pagination for individual subcategories
class SubcategoryPaginationState {
  final int subcategoryId;
  final List<ProductModel> products;
  final int currentPage;
  final bool hasMoreData;

  SubcategoryPaginationState({
    required this.subcategoryId,
    this.products = const [],
    this.currentPage = 1,
    this.hasMoreData = true,
  });

  SubcategoryPaginationState copyWith({
    int? subcategoryId,
    List<ProductModel>? products,
    int? currentPage,
    bool? hasMoreData,
  }) {
    return SubcategoryPaginationState(
      subcategoryId: subcategoryId ?? this.subcategoryId,
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      hasMoreData: hasMoreData ?? this.hasMoreData,
    );
  }
}
