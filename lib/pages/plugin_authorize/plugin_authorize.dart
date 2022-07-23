import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_authorize/plugin_authorize_bloc.dart';
import 'package:help_us_extension/pages/wrapper/wrapper.dart';
import 'package:help_us_extension/utils/app_colors.dart';
import 'package:help_us_extension/widgets/help_us_logo.dart';

import '../../utils/transition.dart';
import '../../widgets/custom_scroll_body.dart';
import '../../widgets/help_us_button.dart';

class PluginAuthorize extends StatefulWidget {
  const PluginAuthorize({Key key}) : super(key: key);

  @override
  State<PluginAuthorize> createState() => _PluginAuthorizeState();
}

class _PluginAuthorizeState extends State<PluginAuthorize> {
  PluginAuthorizeBloc bloc = PluginAuthorizeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<PluginAuthorizeState>(
            stream: bloc.stream,
            builder: (context, state) {
              return CustomScrollBody(
                  isLoading: !state.hasData || state.data.isLoading,
                  slivers: [
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
                                onPressed: () async {
                                  bool result = await bloc.authorizeUser();
                                  if (result) {
                                    if (mounted) {
                                      Navigator.pushReplacement(context,
                                          createRoute(const Wrapper()));
                                    }
                                  }
                                },
                                buttonText: 'Authorize with Square',
                                buttonColor: AppColors.secondary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]);
            }));
  }
}
