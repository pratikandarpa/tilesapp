import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class GenericResponse<T> {
  @JsonKey(name: "status")
  int? status;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "Result")
  T? data;

  GenericResponse();

  factory GenericResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$GenericResponseFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$GenericResponseToJson<T>(this, toJsonT);
}
