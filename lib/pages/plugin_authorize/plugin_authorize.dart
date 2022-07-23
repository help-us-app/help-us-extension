import 'package:flutter/material.dart';
import 'package:help_us_extension/utils/app_colors.dart';
import 'package:help_us_extension/widgets/help_us_logo.dart';

import '../../widgets/custom_scroll_body.dart';
import '../../widgets/help_us_button.dart';

class PluginAuthorize extends StatefulWidget {
  const PluginAuthorize({Key key}) : super(key: key);

  @override
  State<PluginAuthorize> createState() => _PluginAuthorizeState();
}

class _PluginAuthorizeState extends State<PluginAuthorize> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollBody(isLoading: false, slivers: [
      const SliverAppBar(
        title: HelpUsLogo(
          fontSize: 30,
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HelpUsButton(
                  onPressed: () {

                  },
                  buttonText: 'Authorize with Square',
                  buttonColor: AppColors.secondary,
                ),
              ],
            ),
          ),
        ),
      ),
    ]));
  }
}
