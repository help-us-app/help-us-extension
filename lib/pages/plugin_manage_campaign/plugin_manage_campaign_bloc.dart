import 'dart:typed_data';

import 'package:help_us_extension/objects/campaign.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:rxdart/rxdart.dart';

import '../../objects/item.dart';
import '../../repositories/repository.dart';

class PluginManageCampaignBloc {
  final BehaviorSubject items = BehaviorSubject<List<Item>>();
  final BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);
  Stream<PluginManageCampaignState> stream;
  Uint8List image;

  PluginManageCampaignBloc(Campaign campaign) {
    stream = CombineLatestStream(
        [items, isLoading],
        (values) => PluginManageCampaignState(
              items: values[0],
              isLoading: values[1],
            ));
    updateItems(campaign.id.toString());
  }

  updateItems(String campaignId) async {
    items.add(await Repository.getItems(campaignId));
  }

  updateCampaign(Campaign campaign) async {
    updateIsLoading(true);
    campaign.completed = image;
    await Repository.updateCampaign(campaign);
    updateIsLoading(false);
  }

  dispose() {
    items.close();
    isLoading.close();
  }

  attachImage() async {
    Uint8List bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker == null) {
      return;
    }
    return bytesFromPicker;
  }

  updateIsLoading(bool isLoading) {
    this.isLoading.add(isLoading);
  }
}

class PluginManageCampaignState {
  final List<Item> items;
  final bool isLoading;

  PluginManageCampaignState({this.items, this.isLoading});
}
