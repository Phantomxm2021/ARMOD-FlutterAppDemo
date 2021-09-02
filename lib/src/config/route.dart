import 'package:armod_flutter_store/src/pages/ar_view.dart';
import 'package:flutter/material.dart';
import 'package:armod_flutter_store/src/pages/mainPage.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (_) => MainPage(),
      '/ar_view': (_) => ARView()
    };
  }
}
