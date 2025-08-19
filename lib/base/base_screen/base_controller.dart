import 'package:flutter/material.dart';
import 'package:tilesapp/common/widget/loading/loading.dart';

import '../viewdata/view_data_notifier.dart';

abstract class BaseController {
  late BuildContext context;

  final _isLoading = ViewDataNotifier<void>(null);

  void setContext(BuildContext context) {
    this.context = context;
  }

  bool isLoading() => _isLoading.value.isLoading;

  void setLoading(bool isLoading) {
    _isLoading.setLoading(isLoading);
    isLoading ? showLoadingDialog() : hideLoadingDialog();
  }

  void showLoadingDialog() {
    LoadingDialog(context).show(cancelable: false);
  }

  void hideLoadingDialog() {
    LoadingDialog(context).hide();
  }

  void init() {}

  void didChangeDependencies() {}

  void didUpdateWidget() {}

  void dispose() {
    _isLoading.dispose();
  }
}
