// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardResponse _$DashboardResponseFromJson(Map<String, dynamic> json) =>
    DashboardResponse(
      status: (json['Status'] as num).toInt(),
      message: json['Message'] as String,
      result: DashboardResult.fromJson(json['Result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardResponseToJson(DashboardResponse instance) =>
    <String, dynamic>{
      'Status': instance.status,
      'Message': instance.message,
      'Result': instance.result,
    };

DashboardResult _$DashboardResultFromJson(Map<String, dynamic> json) =>
    DashboardResult(
      categories:
          (json['Category'] as List<dynamic>)
              .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$DashboardResultToJson(DashboardResult instance) =>
    <String, dynamic>{'Category': instance.categories};

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      id: (json['Id'] as num).toInt(),
      name: json['Name'] as String,
      isAuthorize: (json['IsAuthorize'] as num?)?.toInt(),
      update080819: (json['Update080819'] as num?)?.toInt(),
      update130919: (json['Update130919'] as num?)?.toInt(),
      subCategories:
          (json['SubCategories'] as List<dynamic>?)
              ?.map((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'IsAuthorize': instance.isAuthorize,
      'Update080819': instance.update080819,
      'Update130919': instance.update130919,
      'SubCategories': instance.subCategories,
    };

SubCategoryModel _$SubCategoryModelFromJson(Map<String, dynamic> json) =>
    SubCategoryModel(
      id: (json['Id'] as num).toInt(),
      name: json['Name'] as String,
      products:
          (json['Product'] as List<dynamic>)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$SubCategoryModelToJson(SubCategoryModel instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Name': instance.name,
      'Product': instance.products,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  name: json['Name'] as String,
  priceCode: json['PriceCode'] as String,
  imageName: json['ImageName'] as String?,
  id: (json['Id'] as num).toInt(),
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'PriceCode': instance.priceCode,
      'ImageName': instance.imageName,
      'Id': instance.id,
    };
