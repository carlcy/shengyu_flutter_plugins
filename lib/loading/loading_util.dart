import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


/// 这个要在项目中使用
class AppNavigatorKey {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

class LoadingUtil {
  static OverlayEntry? _overlayEntry;
  static bool _isLoading = false;

  static void showLoading() {
    if (_isLoading) return; // 如果已经在加载中，直接返回
    _isLoading = true;

    _overlayEntry = OverlayEntry(
      builder: (context) => _buildLoadingOverlay(),
    );
    AppNavigatorKey.navigatorKey.currentState?.overlay?.insert(_overlayEntry!);
  }

  static void hideLoading() {
    _isLoading = false;
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static Widget _buildLoadingOverlay() {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          height: 88.0.h,
          width: 120.0.w,
          decoration: const ShapeDecoration(
            color: Color(0xFF3A3A3A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: ThemeData(
                  cupertinoOverrideTheme: const CupertinoThemeData(
                    brightness: Brightness.dark,
                  ),
                ),
                child: CupertinoActivityIndicator(radius: 14.0.r,color: Colors.white,),
              ),
              SizedBox(height: 8.h),
              const Text(
                '加载中...',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  static bool isLoading() {
    return _isLoading;
  }
}