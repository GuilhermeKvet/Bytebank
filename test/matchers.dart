import 'package:flutter/material.dart';
import 'package:new_bytebank/screens/dashboard/dashbord_future_item.dart';

bool featureItemMatcher(Widget widget, String name, IconData icon) {
  if (widget is FeatureItem) {
    return widget.name == name && widget.icon == icon;
  }
  return false;
}
