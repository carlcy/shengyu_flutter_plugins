import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class Toast {
  static void show(String? msg, {int duration = 2000}) {
    if (msg == null) {
      return;
    }
    showToast(msg,
        duration: Duration(milliseconds: duration),
        dismissOtherToast: true,
        position: ToastPosition.center);
  }

  static void showToastWithWidget(Widget? widget,
      {int duration = 2000, BuildContext? context}) {
    if (widget == null) {
      return;
    }
    showToastWidget(
      widget,
      duration: Duration(milliseconds: duration),
      dismissOtherToast: true,
      position: ToastPosition.center,
    );
  }

  static void cancelToast() {
    dismissAllToast();
  }
}
