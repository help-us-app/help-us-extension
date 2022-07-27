import 'package:flutter/material.dart';
import 'package:help_us_extension/pages/plugin_start_campaign/plugin_start_campaign_bloc.dart';
import 'package:help_us_extension/utils/messenger.dart';
import 'package:help_us_extension/widgets/custom_scroll_body.dart';

import '../../objects/item.dart';
import '../../utils/app_colors.dart';
import '../../widgets/help_us_button.dart';
import '../../widgets/help_us_text_field.dart';
import '../../widgets/start_campaign_text.dart';

class PluginStartCampaign extends StatefulWidget {
  final List<Item> items;

  const PluginStartCampaign({Key key, this.items}) : super(key: key);

  @override
  State<PluginStartCampaign> createState() => _PluginStartCampaignState();
}

class _PluginStartCampaignState extends State<PluginStartCampaign> {
  PluginStartCampaignBloc bloc = PluginStartCampaignBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<PluginStartCampaignState>(
          stream: bloc.stream,
          initialData: PluginStartCampaignState(isLoading: false),
          builder: (context, state) {
            return CustomScrollBody(
              isLoading: !state.hasData || state.data.isLoading,
              slivers: [
                const SliverAppBar(
                  floating: true,
                  snap: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: StartCampaignText(),
                    centerTitle: true,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverToBoxAdapter(
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.items.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Messenger.sendSnackBarMessage(
                                  context, widget.items[index].title);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: SizedBox(
                                width: 100,
                                child: Card(
                                  child: Image.network(
                                      widget.items[index].productImage),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
                          HelpUsTextField(
                            obscure: false,
                            controller: bloc.title,
                            enabled: true,
                            value: "Campaign Name",
                            prefix: Icons.favorite,
                          ),
                          HelpUsTextField(
                            obscure: false,
                            controller: bloc.description,
                            lines: 3,
                            enabled: true,
                            value: "Campaign Description",
                          ),
                          HelpUsButton(
                            onPressed: () async {
                              await showAttachDialog(context);
                              await bloc.createCampaign(widget.items);
                              if (!mounted) {
                                return;
                              }
                              Navigator.of(context).pop();
                              Messenger.sendSnackBarMessage(
                                  context, "Your campaign has been created!");
                            },
                            buttonText: 'Start Campaign',
                            buttonColor: AppColors.secondary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  showAttachDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Add a photo to your campaign?',
            textAlign: TextAlign.center,
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                bloc.image = await bloc.attachImage();
                if (mounted) {
                  if (bloc.image != null) {
                    Navigator.of(context).pop();
                  }
                }
              },
              child: const Text(
                'Yes',
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
