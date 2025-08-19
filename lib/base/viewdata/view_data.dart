import '../../utils/error/failure.dart';

class ViewData<T> {
  final T? data;
  final bool isLoading;
  final Failure? error;

  const ViewData(this.data, {this.isLoading = false, this.error});

  ViewData<T> copyWith({T? data, bool? isLoading, Failure? error}) {
    if (_nothingHasChanged(data, isLoading, error)) return this;

    return ViewData(
      data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  bool _nothingHasChanged(data, bool? isLoading, Failure? error) {
    return (data == null || identical(data, this.data)) &&
        (identical(isLoading, this.isLoading)) &&
        (identical(error, this.error));
  }
}
