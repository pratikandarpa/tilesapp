// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardRequest _$DashboardRequestFromJson(Map<String, dynamic> json) =>
    DashboardRequest(
      categoryId: (json['CategoryId'] as num).toInt(),
      pageIndex: (json['PageIndex'] as num).toInt(),
    );

Map<String, dynamic> _$DashboardRequestToJson(DashboardRequest instance) =>
    <String, dynamic>{
      'CategoryId': instance.categoryId,
      'PageIndex': instance.pageIndex,
    };
