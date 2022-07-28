import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_manage_campaign/plugin_manage_campaign_bloc.dart';

import '../../widgets/custom_scroll_body.dart';
import '../../widgets/row.dart';

class PluginManageCampaign extends StatefulWidget {
  final String campaignId;
  const PluginManageCampaign({Key key, this.campaignId}) : super(key: key);

  @override
  State<PluginManageCampaign> createState() => _PluginManageCampaignState();
}

class _PluginManageCampaignState extends State<PluginManageCampaign> {
  PluginManageCampaignBloc bloc;

  @override
  void initState() {
    bloc = PluginManageCampaignBloc(widget.campaignId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<PluginManageCampaignState>(
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
                              title: Text('Manage Campaign'),
                              centerTitle: true,
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  log(state.data.items[index]
                                      .toJson()
                                      .toString());
                                  return ItemRow(
                                      title: state.data.items[index].title,
                                      price: state.data.items[index].price,
                                      image:
                                          state.data.items[index].productImage,
                                      isPurchased:
                                          state.data.items[index].purchased,
                                      onTap: () {});
                                },
                                childCount: state.data.items.length,
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
            }));
  }
}
