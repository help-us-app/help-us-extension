import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/wrapper/wrapper.dart';
import 'package:help_us_extension/utils/app_themes.dart';
import 'package:help_us_extension/utils/db.dart';

Future<void> main() async {
  await DB().init();
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
        child: const Wrapper(),
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      ),
    );
  }
}