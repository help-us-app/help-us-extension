
import 'package:flutter/material.dart';
import 'package:help_us_extension/objects/campaign.dart';
import 'package:help_us_extension/pages/plugin_manage_campaign/plugin_manage_campaign_bloc.dart';

import '../../utils/app_colors.dart';
import '../../utils/messenger.dart';
import '../../widgets/custom_scroll_body.dart';
import '../../widgets/help_us_button.dart';
import '../../widgets/row.dart';

class PluginManageCampaign extends StatefulWidget {
  final Campaign campaign;
  const PluginManageCampaign({Key key, this.campaign}) : super(key: key);

  @override
  State<PluginManageCampaign> createState() => _PluginManageCampaignState();
}

class _PluginManageCampaignState extends State<PluginManageCampaign> {
  PluginManageCampaignBloc bloc;

  @override
  void initState() {
    bloc = PluginManageCampaignBloc(widget.campaign);
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
                              title: Text('Manage Wishlist'),
                              centerTitle: true,
                            ),
                          ),
                          if (!widget.campaign.isCompleted &&
                              state.data.items.every((item) => item.purchased))
                            SliverPadding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 20,
                              ),
                              sliver: SliverToBoxAdapter(
                                child: HelpUsButton(
                                  onPressed: () async {
                                    await showAttachDialog(context);
                                    if (bloc.image != null) {
                                      await bloc
                                          .updateCampaign(widget.campaign);
                                      if (mounted) {
                                        Navigator.of(context).pop();
                                        Messenger.sendSnackBarMessage(context,
                                            "Your wishlist has been completed!");
                                      }
                                    }
                                  },
                                  buttonText: 'Complete Wishlist',
                                  buttonColor: AppColors.secondary,
                                ),
                              ),
                            ),
                          SliverPadding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return ItemRow(
                                      title: state.data.items[index].title,
                                      price: state.data.items[index].price,
                                      image: state.data.items[index].productImage,
                                      boughtBy: state.data.items[index].boughtBy,
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

  showAttachDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text(
            'Add the confirmation image to your campaign to complete it.',
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
                'Select',
                textAlign: TextAlign.center,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
