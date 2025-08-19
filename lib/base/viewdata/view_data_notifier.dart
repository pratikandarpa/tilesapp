import 'package:flutter/material.dart';
import 'package:tilesapp/base/viewdata/view_data.dart';

import '../../utils/error/failure.dart';

class ViewDataNotifier<T> extends ValueNotifier<ViewData<T>> {
  ViewDataNotifier(T? value) : super(ViewData(value));

  setLoading(bool newValue) {
    if (value.isLoading == newValue) return;
    value = value.copyWith(isLoading: newValue);
    notifyListeners();
  }

  setError(Failure newValue) {
    if (value.error == newValue) return;
    value = value.copyWith(error: newValue);
    notifyListeners();
  }

  setData(T? newValue) {
    if (value.data == newValue) return;
    value = value.copyWith(data: newValue);
    notifyListeners();
  }
}
