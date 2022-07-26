import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:help_us_extension/objects/campaign.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:rxdart/rxdart.dart';

import '../../objects/item.dart';
import '../../repositories/repository.dart';
import '../../utils/db.dart';

class PluginStartCampaignBloc {
  Stream<PluginStartCampaignState> stream;
  BehaviorSubject isLoading = BehaviorSubject.seeded(false);
  TextEditingController title = TextEditingController(),
      description = TextEditingController();
  DB db = DB();
  Uint8List image;

  PluginStartCampaignBloc() {
    stream = CombineLatestStream(
        [
          isLoading,
        ],
        (values) => PluginStartCampaignState(
              isLoading: values[0],
            ));
  }

  dispose() {
    isLoading.close();
    title.dispose();
    description.dispose();
  }

  attachImage() async {
    Uint8List bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    if (bytesFromPicker == null) {
      return;
    }
    return bytesFromPicker;
  }

  createCampaign(List<Item> items, String locationId) async {
    setLoading(true);
    List<Item> duplicatedItems = [];

    for (Item item in items) {
      int quantity = int.parse(item.quantity);
      if (quantity > 1) {
        for (int i = 1; i < quantity; i++) {
          duplicatedItems.add(item);
        }
      }
    }

    items.addAll(duplicatedItems);

    Campaign campaign = Campaign(
        name: title.text,
        description: description.text,
        items: items,
        image: image,
        locationId: locationId);
    await Repository.createCampaign(campaign);

    setLoading(false);
  }

  setLoading(bool loading) {
    isLoading.add(loading);
  }
}

class PluginStartCampaignState {
  final bool isLoading;
  PluginStartCampaignState({this.isLoading});
}
