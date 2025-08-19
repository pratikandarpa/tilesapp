// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListRequest _$ProductListRequestFromJson(Map<String, dynamic> json) =>
    ProductListRequest(
      pageIndex: (json['PageIndex'] as num).toInt(),
      subCategoryId: (json['SubCategoryId'] as num).toInt(),
    );

Map<String, dynamic> _$ProductListRequestToJson(ProductListRequest instance) =>
    <String, dynamic>{
      'PageIndex': instance.pageIndex,
      'SubCategoryId': instance.subCategoryId,
    };
