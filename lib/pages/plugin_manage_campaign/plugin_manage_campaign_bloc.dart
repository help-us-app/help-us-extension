import 'package:rxdart/rxdart.dart';

import '../../objects/item.dart';
import '../../repositories/repository.dart';

class PluginManageCampaignBloc {
  final BehaviorSubject items = BehaviorSubject<List<Item>>();
  final BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);
  Stream<PluginManageCampaignState> stream;
  PluginManageCampaignBloc(String campaignId) {
    stream = CombineLatestStream(
        [items, isLoading],
        (values) => PluginManageCampaignState(
              items: values[0],
              isLoading: values[1],
            ));
    updateItems(campaignId);
  }

  updateItems(String campaignId) async {
    items.add(await Repository.getItems(campaignId));
  }

  dispose() {
    items.close();
    isLoading.close();
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
