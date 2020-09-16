import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_page_resume/navigation_mixin.dart';
import 'package:flutter_page_resume/navigation_util.dart';


//void main() => runApp(FlutterReduxApp());
//默认入口
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(_widgetForRoute(window.defaultRouteName));
}

void association() {
  //新入口
  WidgetsFlutterBinding.ensureInitialized();
  runApp(_widgetForRoute(window.defaultRouteName));
}

Widget _widgetForRoute(String route) {
  // 强制竖屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return FlutterReduxApp();
}

class FlutterReduxApp extends StatefulWidget {
  @override
  _FlutterReduxAppState createState() => _FlutterReduxAppState();
}

class _FlutterReduxAppState extends State<FlutterReduxApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: GlobalKey<NavigatorState>(),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        NavigationUtil.getInstance(),
      ],
      routes: {
        SplashPage.sName: (_) => SplashPage(),
        TwoPage.sName: (_) => TwoPage()
      },
    );
  }
}



class SplashPage extends StatefulWidget {
  static final String sName = "/";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NavigationMixin{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            GestureDetector(
              onTap: (){
                NavigationUtil.getInstance().pushNamed(TwoPage.sName);
              },
              child: Text(
                  'page'
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  String get routName =>  SplashPage.sName ;

  @override
  void onFocus() {
    print('2222');
    super.onFocus();

  }

  @override
  void onBlur() {
    print('1111');
    super.onBlur();
  }
}


class TwoPage extends StatefulWidget {
  static final String sName = "two";

  @override
  _TwoPagePageState createState() => _TwoPagePageState();
}

class _TwoPagePageState extends State<TwoPage> with NavigationMixin{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
                'two page'
            ),
          ],
        ),
      ),
    );
  }

  @override
  String get routName =>  TwoPage.sName ;

  @override
  void onFocus() {
    print('2222===');
    super.onFocus();
  }

  @override
  void onBlur() {
    print('1111===');
    super.onBlur();
  }

}
