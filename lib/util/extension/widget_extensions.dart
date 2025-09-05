import 'package:flutter/material.dart';

extension SpacedChildren on List {
  /// 在每个元素之间插入垂直间距（用于 Column）
  List<Widget> withSpacing(double spacing) {
    if (isEmpty) return [];

    final List<Widget> result = [];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) {
        result.add(SizedBox(height: spacing));
      }
    }
    return result;
  }

  /// 在每个元素之间插入水平间距（用于 Row）
  List<Widget> withHorizontalSpacing(double spacing) {
    if (isEmpty) return [];

    final List<Widget> result = [];
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1) {
        result.add(SizedBox(width: spacing));
      }
    }
    return result;
  }
}