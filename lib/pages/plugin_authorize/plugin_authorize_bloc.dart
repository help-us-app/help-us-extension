import 'package:help_us_extension/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../objects/user.dart';
import '../../utils/db.dart';

class PluginAuthorizeBloc {
  Stream<PluginAuthorizeState> stream;
  BehaviorSubject isLoading = BehaviorSubject.seeded(false);
  bool isBrowser = false;
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
    userId ??= (await Repository.createUser()).id;
    db.setUser(userId);

    if (userId != null) {
      if (isBrowser) {
        bool authorized = false;
        while (!authorized) {
          await Future.delayed(const Duration(seconds: 1));
          User user = await Repository.getUserById(userId);
          if (user != null) {
            if (user.merchantId != null) {
              authorized = true;
              return true;
            }
          }
        }
      }

      Future.delayed(const Duration(seconds: 1), () {
        launchUrlString("${Repository.herokuUrl}oauth/url?user_id=$userId");
        setLoading(false);
      });
    }

    return false;
  }
}

class PluginAuthorizeState {
  final bool isLoading;
  PluginAuthorizeState({this.isLoading});
}
