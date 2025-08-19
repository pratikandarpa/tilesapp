import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tilesapp/common/constants/string_constants.dart';

import '../../base/base_screen/base_screen.dart';
import '../../common/constants/color_constants.dart';
import '../../model/response/dashboard_response.dart';
import '../routes.dart';
import 'home_controller.dart';
import 'widgets/category_tab_bar.dart';
import 'widgets/custom_app_bar.dart';

/// Main home screen widget that displays categories and their subcategories
class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

/// State class for HomeScreen with category selection and pagination functionality
class _HomeScreenState extends BaseScreenState<HomeScreen, HomeController> {
  @override
  void initState() {
    super.initState();
    // Initialize pagination data for subcategories when they become available
    ever(controller.categoryData, (List<CategoryModel> categories) {
      for (final category in categories) {
        if (category.subCategories != null) {
          for (final subcategory in category.subCategories!) {
            controller.initializeSubcategoryPagination(subcategory.id, subcategory.products);
          }
        }
      }
    });
  }

  @override
  Widget buildWidget() {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Obx(() {
        return Column(
          children: [
            // Category Tab Bar
            CategoryTabBar(
              categories: controller.getCategoryNames(),
              selectedIndex: controller.selectedCategoryIndex.value,
              onCategorySelected: (index) {
                controller.selectCategory(index);
              },
            ),
            // Subcategory Content with Pagination
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  // Handle infinite scroll - load more data when user reaches bottom
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                      !controller.isLoadingMore.value &&
                      controller.hasMoreData.value) {
                    controller.loadMoreCategoryData();
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        // Display subcategories if data exists for selected category
                        if (controller.hasCurrentCategoryData) {
                          return _buildSubcategorySection(
                            controller.getCurrentCategoryName(),
                            controller.getCurrentCategorySubcategories(),
                          );
                        } else {
                          // Display empty state when no products available for selected category
                          return Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.inventory_2_outlined,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  StringConstants.noProduct,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                      // Loading indicator for pagination
                      Obx(() {
                        if (controller.isLoadingMore.value) {
                          return const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Routes.go(Routes.strip);
        },
        tooltip: 'Test Strip',
        child: const Icon(Icons.color_lens_outlined),
      ),
    );
  }

  /// Build subcategory section with horizontal pagination support
  Widget _buildSubcategorySection(String categoryName, List<SubCategoryModel> subcategories) {
    return Container(
      color: ColorConstants.white,
      child: Column(
        children:
            subcategories.map((subcategory) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      subcategory.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstants.primary,
                      ),
                    ),
                  ),
                  Obx(() {
                    final products = controller.getProductsForSubcategory(subcategory.id);
                    final hasMoreData = controller.hasMoreProductsForSubcategory(subcategory.id);
                    final isLoadingMore = controller.isLoadingMoreProductsForSubcategory(
                      subcategory.id,
                    );

                    return SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: products.length + (hasMoreData ? 1 : 0),
                        itemBuilder: (context, index) {
                          // Show loading indicator or load more button at the end
                          if (index == products.length) {
                            if (isLoadingMore) {
                              return Container(
                                width: 60,
                                margin: const EdgeInsets.only(right: 16),
                                child: const Center(child: CircularProgressIndicator()),
                              );
                            } else if (hasMoreData) {
                              return Center(
                                child: Container(
                                  width: 60,
                                  margin: const EdgeInsets.only(right: 16),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        controller.loadMoreProductsForSubcategory(subcategory.id);
                                      },
                                      icon: const Icon(
                                        Icons.add_circle_outline,
                                        color: ColorConstants.primary,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }

                          final product = products[index];
                          return Container(
                            width: 150,
                            margin: const EdgeInsets.only(right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: ColorConstants.lightGrey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child:
                                          product.imageName != null
                                              ? ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  product.imageName!,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error, stackTrace) {
                                                    return Container(
                                                      color: ColorConstants.lightGrey,
                                                      child: const Icon(
                                                        Icons.image,
                                                        color: ColorConstants.grey,
                                                        size: 40,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                              : const Icon(
                                                Icons.image,
                                                color: ColorConstants.grey,
                                                size: 40,
                                              ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorConstants.blue,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          product.priceCode,
                                          style: const TextStyle(
                                            color: ColorConstants.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstants.primary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                ],
              );
            }).toList(),
      ),
    );
  }
}
