import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class RouteInfo {
  Route currentRoute;
  List<Route> routes;

  RouteInfo(this.currentRoute, this.routes);

  @override
  String toString() {
    return 'RouteInfo{currentRoute: $currentRoute, routes: $routes}';
  }

}

class NavigationUtil extends NavigatorObserver{
  static NavigationUtil _instance;



  ///路由信息
  RouteInfo _routeInfo;
  RouteInfo get routeInfo => _routeInfo;
  ///stream相关
  static StreamController _streamController;
  StreamController<RouteInfo> get streamController=> _streamController;
  ///用来路由跳转
  static NavigatorState navigatorState;


  static NavigationUtil getInstance() {
    if (_instance == null) {
      _instance = new NavigationUtil();
      _streamController = StreamController<RouteInfo>.broadcast();
    }
    return _instance;
  }

  ///push页面
  Future<T> pushNamed<T>(String routeName,{Object arguments}) {
    return navigatorState.pushNamed(routeName,arguments:arguments);
  }

//  ///push页面
//  Future<T> push<T>(String routeName,{Object arguments}) {
//    return OneContext().pushNamed(routeName,arguments:arguments);
//  }

  Future<T> push<T extends Object>(Route<T> route) {
    return navigatorState.push(route);
  }


  ///replace页面
  Future<T> pushReplacementNamed<T, R>(String routeName,
      {R result,
        Object arguments}) {
    return navigatorState.pushReplacementNamed(routeName,result: result,arguments: arguments);
  }

  // pop 页面
  pop<T>([T result]) {
    navigatorState.pop<T>(result);
  }

  pushNamedAndRemoveUntil(String newRouteName) {
    return navigatorState.pushNamedAndRemoveUntil(newRouteName, (Route<dynamic> route) => false);
  }


  //进入路由
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    if (_routeInfo == null) {
      _routeInfo = new RouteInfo(null, new List<Route>());
    }

    print('----------push-----------');
    print('---------：${route.settings}');
    print('---------：${previousRoute?.settings}');
    print('----------end-----------');

    ///这里过滤调push的是dialog的情况
    if (route is CupertinoPageRoute || route is MaterialPageRoute) {
      _routeInfo.routes.add(route);
      routeObserver();
    }
  }
//用新路由替换旧路由
  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    super.didReplace();
    print('----------didReplace-----------');
    print('---------：${newRoute.settings}');
    print('---------：${oldRoute?.settings}');
    print('----------end-----------');

    if (newRoute is CupertinoPageRoute || newRoute is MaterialPageRoute) {
      _routeInfo.routes.remove(oldRoute);
      _routeInfo.routes.add(newRoute);
      routeObserver();
    }
  }
//弹出路由
  @override
  void didPop(Route route, Route previousRoute) {
    print('----------didPop-----------');
    print('---------：${route.settings}');
    print('---------：${previousRoute?.settings}');
    print('----------end-----------');
    super.didPop(route, previousRoute);
    if (route is CupertinoPageRoute || route is MaterialPageRoute) {
      _routeInfo.routes.remove(route);
      routeObserver();
    }
  }
//删除路由
  @override
  void didRemove(Route removedRoute, Route oldRoute) {

    print('----------didRemove-----------');
    print('---------：${removedRoute.settings}');
    print('---------：${oldRoute?.settings}');

    super.didRemove(removedRoute, oldRoute);
    if (removedRoute is CupertinoPageRoute || removedRoute is MaterialPageRoute) {
      _routeInfo.routes.remove(removedRoute);
      routeObserver();
    }
  }



  void routeObserver() {
    _routeInfo.currentRoute = _routeInfo.routes.last;
    navigatorState = _routeInfo.currentRoute.navigator;
    _streamController.sink.add(_routeInfo);


  }



}