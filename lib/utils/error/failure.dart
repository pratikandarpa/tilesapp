import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;
  final int? status;

  const Failure({this.status = 0, this.message});

  @override
  List<Object?> get props => [];
}

class FailureStatus {
  static const int internet = 0;
  static const int server = 1;
  static const int cache = 2;
  static const int session = 3;
  static const int unauthorized = 401;
}

class FailureMessage {
  static const String session = 'Token has expired';
  static const String server = 'Server error';
  static const String unexpected = 'Unexpected error D:';
  static const String internet = 'Looks like you don\'t have internet :(';
}
