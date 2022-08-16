import 'package:help_us_extension/objects/item.dart';
import 'package:rxdart/rxdart.dart';

import '../../objects/location.dart';
import '../../objects/user.dart';
import '../../repositories/repository.dart';

class PluginDashboardBloc {
  Stream<PluginDashboardState> stream;
  BehaviorSubject isLoading = BehaviorSubject.seeded(false);
  BehaviorSubject<List<Location>> locations = BehaviorSubject();
  BehaviorSubject<User> user = BehaviorSubject();

  PluginDashboardBloc(User user) {
    stream = CombineLatestStream(
        [
          isLoading.stream,
          locations.stream,
          this.user.stream,
        ],
        (results) => PluginDashboardState(
            isLoading: results[0], locations: results[1], user: results[2]));
    updateLocations(user.id);
    updateUser(user.id);
  }

  dispose() {
    isLoading.close();
    locations.close();
    user.close();
  }

  Future<void> updateUser(String userId) async {
    user.add(await Repository.getUserById(userId));
  }

  void setIsLoading(bool isLoading) => this.isLoading.add(isLoading);

  Future<void> updateLocations(String userId) async {
    locations.add(await Repository.getLocations(userId));
  }

  setLocation(String locationId, String userId) async {
    setIsLoading(true);
    await Repository.setLocation(locationId, userId);
    await updateUser(userId);
    setIsLoading(false);
  }

  Future<void> removeLocationId(String userId) async {
    setIsLoading(true);
    await Repository.setLocation(null, userId);
    await updateUser(userId);
    setIsLoading(false);
  }

  Future<List<Item>> scrapeCart(String webpage, String url) async {
    return await Repository.scrapeCart(webpage, url);
  }
}

class PluginDashboardState {
  final List<Location> locations;
  final bool isLoading;
  final User user;
  PluginDashboardState({this.locations, this.isLoading, this.user});
}
