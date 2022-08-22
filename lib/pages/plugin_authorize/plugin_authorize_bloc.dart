import 'package:help_us_extension/repositories/repository.dart';
import 'package:help_us_extension/utils/const.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../objects/user.dart';
import '../../utils/db.dart';

class PluginAuthorizeBloc {
  Stream<PluginAuthorizeState> stream;
  BehaviorSubject isLoading = BehaviorSubject.seeded(false);
  DB db = DB();

  PluginAuthorizeBloc() {
    stream = CombineLatestStream(
        [
          isLoading,
        ],
        (values) => PluginAuthorizeState(
              isLoading: values[0],
            ));
  }

  setLoading(bool loading) {
    isLoading.add(loading);
  }

  Future<bool> authorizeUser() async {
    setLoading(true);
    String userId = db.getUser();
    if (userId == null) {
      userId = (await Repository.createUser()).id;
      db.setUser(userId);
    }

    if (userId != null) {
      Future.delayed(const Duration(milliseconds: Constant.load), () {
        launchUrlString("${Repository.herokuUrl}oauth/url?user_id=$userId");
      });
    }

    setLoading(false);

    return false;
  }

  Future<bool> authorizeSampleUser() async {
    setLoading(true);
    String userId = db.getUser();
    if (userId == null) {
      userId = (await Repository.createUser(
              user: User(
                  merchantId: const String.fromEnvironment("SAMPLE_MERCHANT_ID"),
                  refreshToken:
                  const String.fromEnvironment("SAMPLE_REFRESH_TOKEN"),
                  expiresIn: Constant.expiredDate,
              )))
          .id;
      db.setUser(userId);
    }

    setLoading(false);

    return false;
  }

  clearUser() {
    db.clearUser();
  }
}

class PluginAuthorizeState {
  final bool isLoading;
  PluginAuthorizeState({this.isLoading});
}
