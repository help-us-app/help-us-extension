import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_authorize/plugin_authorize.dart';

import 'package:help_us_extension/pages/wrapper/wrapper_bloc.dart';

import '../../utils/const.dart';
import '../loading_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  WrapperState createState() => WrapperState();
}

class WrapperState extends State<Wrapper> {
  WrapperBloc wrapperBloc = WrapperBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    wrapperBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: wrapperBloc.user,
        builder: (context, snapshot) {
          Widget child = const LoadingPage();

          if (snapshot.hasData) {
            wrapperBloc.db.clearUser();
            child = Container();
          }

          if (snapshot.hasError) {
            child = const PluginAuthorize();
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: Constant.load),
            child: child,
          );
        });
  }
}
