import 'package:flutter/material.dart';
import 'package:tilesapp/ui/routes.dart';

import '../../constants/color_constants.dart';

Future _showLoadingDialog(BuildContext c, Widget loading, {bool cancelable = true}) {
  return showDialog(
    context: c,
    barrierDismissible: cancelable,
    builder: (BuildContext c) => loading,
  );
}

bool _isLoadingDialog = false;

class LoadingDialog extends Dialog {
  final BuildContext _context;

  const LoadingDialog(this._context, {Key? key}) : super(key: key);

  show({bool cancelable = true}) {
    _isLoadingDialog = true;
    _showLoadingDialog(_context, this, cancelable: cancelable).then((_) {
      _isLoadingDialog = false;
    });
  }

  hide() {
    if (_isLoadingDialog) {
      Routes.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(type: MaterialType.transparency, child: Loading());
  }
}

class Loading extends StatelessWidget {
  final double strokeWidth;

  const Loading({Key? key, this.strokeWidth = 4.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: const AlwaysStoppedAnimation<Color>(ColorConstants.primary),
      ),
    );
  }
}
