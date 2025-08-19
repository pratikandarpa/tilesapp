// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) =>
    ProductListResponse(
      status: (json['Status'] as num).toInt(),
      message: json['Message'] as String,
      result:
          (json['Result'] as List<dynamic>)
              .map((e) => ProductListItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ProductListResponseToJson(
  ProductListResponse instance,
) => <String, dynamic>{
  'Status': instance.status,
  'Message': instance.message,
  'Result': instance.result,
};

ProductListItem _$ProductListItemFromJson(Map<String, dynamic> json) =>
    ProductListItem(
      name: json['Name'] as String,
      priceCode: json['PriceCode'] as String,
      imageName: json['ImageName'] as String?,
      id: (json['Id'] as num).toInt(),
    );

Map<String, dynamic> _$ProductListItemToJson(ProductListItem instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'PriceCode': instance.priceCode,
      'ImageName': instance.imageName,
      'Id': instance.id,
    };
