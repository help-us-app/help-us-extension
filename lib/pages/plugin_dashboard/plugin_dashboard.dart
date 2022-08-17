import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:help_us_extension/pages/plugin_dashboard/plugin_dashboard_bloc.dart';
import 'package:help_us_extension/pages/plugin_start_campaign/plugin_start_campaign.dart';
import 'package:help_us_extension/widgets/custom_scroll_body.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../objects/item.dart';
import '../../objects/user.dart';
import '../../utils/app_colors.dart';
import '../../utils/const.dart';
import '../../utils/javascript.dart';
import '../../utils/messenger.dart';
import '../../utils/transition.dart';
import '../../widgets/help_us_button.dart';
import '../../widgets/help_us_logo.dart';
import '../../widgets/location_card.dart';
import '../../widgets/start_campaign_button.dart';
import '../../widgets/two_tone_text.dart';
import '../plugin_manage_campaigns/plugin_manage_campaigns.dart';

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
                      state.data.user.locationId != null
                          ? SliverPadding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              sliver: SliverAppBar(
                                backgroundColor: Colors.transparent,
                                title: const HelpUsLogo(
                                  hasForChrome: true,
                                  fontSize: 30,
                                ),
                                actions: [
                                  InkWell(
                                    child: const Icon(FontAwesome.share),
                                    onTap: () {
                                      Clipboard.setData(ClipboardData(
                                          text:
                                              '${Constant.helpUsWebUrl}${widget.user.locationId}/${widget.user.id}'));
                                      Messenger.sendSnackBarMessage(context,
                                          'Copied a shareable link to your clipboard.');
                                    },
                                  )
                                ],
                              ),
                            )
                          : const SliverAppBar(
                              floating: true,
                              snap: true,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              flexibleSpace: FlexibleSpaceBar(
                                title: TwoToneText(
                                  firstText: "Select a ",
                                  secondText: "Location",
                                ),
                                centerTitle: true,
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
                      if (state.data.user.locationId != null)
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                StartCampaignButton(
                                  onPressed: () async {
                                    String url = await getUrl();
                                    var webpage = await getHtml();
                                    webpage = await promiseToFuture(webpage);
                                    url = await promiseToFuture(url);
                                    if (webpage == null) {
                                      if (mounted) {
                                        Messenger.sendSnackBarMessage(context,
                                            'Could not load the webpage. Please try again later.');
                                      }
                                      return;
                                    }
                                    List<Item> items =
                                        await bloc.scrapeCart(webpage, url);
                                    if (items == null) {
                                      if (mounted) {
                                        Messenger.sendSnackBarMessage(context,
                                            "Sorry, we don't support this page.");
                                      }
                                      return;
                                    }
                                    if (items.isEmpty) {
                                      if (mounted) {
                                        Messenger.sendSnackBarMessage(context,
                                            'No items found in the cart. Please add items to the cart and try again.');
                                      }
                                      return;
                                    }
                                    if (mounted) {
                                      Navigator.of(context)
                                          .push(createRoute(PluginStartCampaign(
                                        items: items,
                                        locationId: state.data.user.locationId,
                                      )));
                                    }
                                  },
                                ),
                                HelpUsButton(
                                  onPressed: () async {
                                    if (mounted) {
                                      Navigator.of(context).push(
                                          createRoute(PluginManageCampaigns(
                                        locationId: state.data.user.locationId,
                                      )));
                                    }
                                  },
                                  buttonText: 'Manage Campaigns',
                                  buttonColor: AppColors.secondary,
                                ),
                                HelpUsButton(
                                  buttonText: "Edit Page",
                                  buttonColor: AppColors.secondary,
                                  onPressed: () async {
                                    launchUrlString(
                                        "${Constant.squareLocationEditPage}${state.data.user.locationId}");
                                  },
                                ),
                                HelpUsButton(
                                  buttonText: "Change Location",
                                  buttonColor: AppColors.secondary,
                                  onPressed: () async {
                                    bloc.removeLocationId(widget.user.id);
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
