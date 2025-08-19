import 'package:json_annotation/json_annotation.dart';

part 'product_list_response.g.dart';

@JsonSerializable()
class ProductListResponse {
  @JsonKey(name: "Status")
  final int status;
  
  @JsonKey(name: "Message")
  final String message;
  
  @JsonKey(name: "Result")
  final List<ProductListItem> result;

  ProductListResponse({
    required this.status,
    required this.message,
    required this.result,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);
}

@JsonSerializable()
class ProductListItem {
  @JsonKey(name: "Name")
  final String name;
  
  @JsonKey(name: "PriceCode")
  final String priceCode;
  
  @JsonKey(name: "ImageName")
  final String? imageName;
  
  @JsonKey(name: "Id")
  final int id;

  ProductListItem({
    required this.name,
    required this.priceCode,
    this.imageName,
    required this.id,
  });

  factory ProductListItem.fromJson(Map<String, dynamic> json) =>
      _$ProductListItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListItemToJson(this);
}
