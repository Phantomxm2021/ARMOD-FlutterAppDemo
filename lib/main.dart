import 'package:armod_flutter_store/src/config/route.dart';
import 'package:armod_flutter_store/src/pages/mainPage.dart';
import 'package:armod_flutter_store/src/pages/ar_experience_detail.dart';
import 'package:armod_flutter_store/src/themes/theme.dart';
import 'package:armod_flutter_store/src/widgets/customRoute.dart';
import 'package:armod_flutter_store/src/widgets/without_scroll_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AR-MOD Store Flutter',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      scrollBehavior: without_scroll_glow(),
      builder: EasyLoading.init(),
      routes: Routes.getRoute(),
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name!.contains('detail')) {
          return CustomRoute<bool>(
              builder: (BuildContext context) => ARExperienceDetailPage());
        } else {
          return CustomRoute<bool>(
              builder: (BuildContext context) => MainPage());
        }
      },
      initialRoute: "MainPage",
    );
  }
}
