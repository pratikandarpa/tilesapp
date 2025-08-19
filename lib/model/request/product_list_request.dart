import 'package:json_annotation/json_annotation.dart';

part 'product_list_request.g.dart';

@JsonSerializable()
class ProductListRequest {
  @JsonKey(name: "PageIndex")
  final int pageIndex;
  
  @JsonKey(name: "SubCategoryId")
  final int subCategoryId;

  ProductListRequest({
    required this.pageIndex,
    required this.subCategoryId,
  });

  factory ProductListRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListRequestToJson(this);
}
