import 'package:help_us_extension/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../objects/campaign.dart';

class PluginManageCampaignsBloc {
  final BehaviorSubject<List<Campaign>> campaigns =
      BehaviorSubject<List<Campaign>>();
  final BehaviorSubject<bool> isLoading = BehaviorSubject.seeded(false);
  Stream<PluginManageCampaignsState> stream;

  PluginManageCampaignsBloc(String locationId) {
    stream = CombineLatestStream(
        [campaigns, isLoading],
        (values) => PluginManageCampaignsState(
              campaigns: values[0],
              isLoading: values[1],
            ));
    updateCampaigns(locationId);
  }

  updateCampaigns(String locationId) async {
    campaigns.add(await Repository.getCampaigns(locationId));
  }

  dispose() {
    campaigns.close();
    isLoading.close();
  }
}

class PluginManageCampaignsState {
  final List<Campaign> campaigns;
  final bool isLoading;

  PluginManageCampaignsState({this.campaigns, this.isLoading});
}
