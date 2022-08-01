import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_manage_campaigns/plugin_manage_campaigns_bloc.dart';
import 'package:help_us_extension/widgets/campaign_card.dart';

import '../../utils/transition.dart';
import '../../widgets/custom_scroll_body.dart';
import '../plugin_manage_campaign/plugin_manage_campaign.dart';

class PluginManageCampaigns extends StatefulWidget {
  final String locationId;
  const PluginManageCampaigns({Key key, this.locationId}) : super(key: key);

  @override
  State<PluginManageCampaigns> createState() => _PluginManageCampaignsState();
}

class _PluginManageCampaignsState extends State<PluginManageCampaigns> {
  PluginManageCampaignsBloc bloc;

  @override
  void initState() {
    bloc = PluginManageCampaignsBloc(widget.locationId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PluginManageCampaignsState>(
          stream: bloc.stream,
          builder: (context, state) {
            return CustomScrollBody(
                isLoading: !state.hasData || state.data.isLoading,
                slivers: state.hasData
                    ? [
                        const SliverAppBar(
                          floating: true,
                          snap: true,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text('Manage Campaigns'),
                            centerTitle: true,
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return CampaignCard(
                                  id: state.data.campaigns[index].id.toString(),
                                  title: state.data.campaigns[index].name,
                                  image: state.data.campaigns[index].image,
                                  description:
                                      state.data.campaigns[index].description,
                                  onTap: () {
                                    if (mounted) {
                                      Navigator.of(context).pushReplacement(
                                          createRoute(PluginManageCampaign(
                                        campaign: state
                                            .data.campaigns[index],
                                      )));
                                    }
                                  },
                                  isCompleted:
                                      state.data.campaigns[index].isCompleted,
                                );
                              },
                              childCount: state.data.campaigns.length,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 30,
                          ),
                        )
                      ]
                    : []);
          }),
    );
  }
}
