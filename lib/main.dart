import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_authorize/plugin_authorize.dart';
import 'package:help_us_extension/utils/app_themes.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'help-us',
      theme: AppThemes.light,
      themeMode: ThemeMode.dark,
      scrollBehavior: MyCustomScrollBehavior(),
      darkTheme: AppThemes.dark,
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        child: const PluginAuthorize(),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}