import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_dashboard/plugin_dashboard_bloc.dart';
import 'package:help_us_extension/widgets/custom_scroll_body.dart';

import '../../objects/user.dart';
import '../../widgets/help_us_logo.dart';
import '../../widgets/location_card.dart';

class PluginDashboard extends StatefulWidget {
  final User user;
  const PluginDashboard({Key key, this.user}) : super(key: key);

  @override
  State<PluginDashboard> createState() => _PluginDashboardState();
}

class _PluginDashboardState extends State<PluginDashboard> {
  PluginDashboardBloc bloc;

  @override
  initState() {
    super.initState();
    bloc = PluginDashboardBloc(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PluginDashboardState>(
          stream: bloc.stream,
          builder: (context, state) {
            return CustomScrollBody(
              isLoading: !state.hasData || state.data.isLoading,
              slivers: state.hasData
                  ? [
                      const SliverAppBar(
                        title: HelpUsLogo(
                          fontSize: 30,
                        ),
                      ),
                      if (state.data.user.locationId == null)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverList(
                              delegate:
                                  SliverChildBuilderDelegate((context, index) {
                            return LocationCard(
                              title: state.data.locations[index].businessName,
                              description:
                                  "${state.data.locations[index].address.addressLine1}\n ${state.data.locations[index].address.country}",
                              url: state.data.locations[index].logoUrl,
                              onTap: () {
                                bloc.setLocation(state.data.locations[index].id,
                                    widget.user.id);
                              },
                              selected: false,
                            );
                          }, childCount: state.data.locations.length)),
                        ),
                    ]
                  : [],
            );
          }),
    );
  }
}
