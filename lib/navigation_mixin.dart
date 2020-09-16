import 'dart:async';
import 'package:flutter/material.dart';
import 'navigation_util.dart';

mixin NavigationMixin<T extends StatefulWidget> on State<T> {
  StreamSubscription<RouteInfo> streamSubscription;
  Route lastRoute;

  @override
  void initState() {
    super.initState();
    streamSubscription = NavigationUtil().streamController.stream.listen((RouteInfo routeInfo) {
      if (routeInfo.currentRoute.settings.name == routName) {
        onFocus();
      }
      /// 第一次监听到路由变化
      if (lastRoute == null) {
        onBlur();
      }
      /// 上一个是该页面，新的路由不是该页面
      if (lastRoute?.settings?.name == routName && routeInfo.currentRoute.settings.name != routName) {
        onBlur();
      }
      lastRoute = routeInfo.currentRoute;

    });
  }

  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
    streamSubscription = null;
  }

  @protected
  String get routName;

  @protected
  void onBlur() {

  }

  @protected
  void onFocus() {

  }
}
