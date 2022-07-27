import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_manage_pages/plugin_manage_campaigns_bloc.dart';
import 'package:help_us_extension/widgets/campaign_card.dart';

import '../../widgets/custom_scroll_body.dart';

class PluginManageCampaign extends StatefulWidget {
  final String locationId;
  const PluginManageCampaign({Key key, this.locationId}) : super(key: key);

  @override
  State<PluginManageCampaign> createState() => _PluginManageCampaignState();
}

class _PluginManageCampaignState extends State<PluginManageCampaign> {
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
                                );
                              },
                              childCount: state.data.campaigns.length,
                            ),
                          ),
                        ),
                      ]
                    : []);
          }),
    );
  }
}
