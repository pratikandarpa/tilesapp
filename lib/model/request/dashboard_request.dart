import 'package:json_annotation/json_annotation.dart';

part 'dashboard_request.g.dart';

@JsonSerializable()
class DashboardRequest {
  @JsonKey(name: "CategoryId")
  final int categoryId;
  
  @JsonKey(name: "PageIndex")
  final int pageIndex;

  DashboardRequest({
    required this.categoryId,
    required this.pageIndex,
  });

  factory DashboardRequest.fromJson(Map<String, dynamic> json) =>
      _$DashboardRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardRequestToJson(this);
}
