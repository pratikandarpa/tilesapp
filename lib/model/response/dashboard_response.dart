import 'package:json_annotation/json_annotation.dart';

part 'dashboard_response.g.dart';

@JsonSerializable()
class DashboardResponse {
  @JsonKey(name: "Status")
  final int status;
  
  @JsonKey(name: "Message")
  final String message;
  
  @JsonKey(name: "Result")
  final DashboardResult result;

  DashboardResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) =>
      _$DashboardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResponseToJson(this);
}

@JsonSerializable()
class DashboardResult {
  @JsonKey(name: "Category")
  final List<CategoryModel> categories;

  DashboardResult({
    required this.categories,
  });

  factory DashboardResult.fromJson(Map<String, dynamic> json) =>
      _$DashboardResultFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardResultToJson(this);
}

@JsonSerializable()
class CategoryModel {
  @JsonKey(name: "Id")
  final int id;
  
  @JsonKey(name: "Name")
  final String name;
  
  @JsonKey(name: "IsAuthorize")
  final int? isAuthorize;
  
  @JsonKey(name: "Update080819")
  final int? update080819;
  
  @JsonKey(name: "Update130919")
  final int? update130919;
  
  @JsonKey(name: "SubCategories")
  final List<SubCategoryModel>? subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    this.isAuthorize,
    this.update080819,
    this.update130919,
    this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}

@JsonSerializable()
class SubCategoryModel {
  @JsonKey(name: "Id")
  final int id;
  
  @JsonKey(name: "Name")
  final String name;
  
  @JsonKey(name: "Product")
  final List<ProductModel> products;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.products,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubCategoryModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  @JsonKey(name: "Name")
  final String name;
  
  @JsonKey(name: "PriceCode")
  final String priceCode;
  
  @JsonKey(name: "ImageName")
  final String? imageName;
  
  @JsonKey(name: "Id")
  final int id;

  ProductModel({
    required this.name,
    required this.priceCode,
    this.imageName,
    required this.id,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
