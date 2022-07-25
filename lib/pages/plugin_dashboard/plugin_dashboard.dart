import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:help_us_extension/pages/plugin_dashboard/plugin_dashboard_bloc.dart';
import 'package:help_us_extension/widgets/custom_scroll_body.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../objects/user.dart';
import '../../utils/app_colors.dart';
import '../../widgets/help_us_button.dart';
import '../../widgets/help_us_logo.dart';
import '../../widgets/location_card.dart';
import '../../widgets/start_campaign_button.dart';

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
                      const SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverAppBar(
                          title: HelpUsLogo(
                            fontSize: 30,
                          ),
                          actions: [
                            Icon(FontAwesome.share)
                          ],
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
                      // sliver grid
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          delegate: SliverChildListDelegate([
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: AppColors.primary,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: AppColors.secondary,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      if (state.data.user.locationId != null)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StartCampaignButton(
                                  onPressed: () async {},
                                ),
                                HelpUsButton(
                                  onPressed: () async {},
                                  buttonText: 'Manage Campaigns',
                                  buttonColor: AppColors.secondary,
                                ),
                                HelpUsButton(
                                  buttonText: "Edit Page",
                                  buttonColor: AppColors.secondary,
                                  onPressed: () async {
                                    launchUrlString(
                                        "https://squareupsandbox.com/dashboard/locations/${state.data.user.locationId}");
                                  },
                                ),
                                HelpUsButton(
                                  buttonText: "Log out",
                                  buttonColor: AppColors.red,
                                  onPressed: () async {
                                    launchUrlString(
                                        "https://squareupsandbox.com/dashboard/locations/${state.data.user.locationId}");
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                    ]
                  : [],
            );
          }),
    );
  }
}
