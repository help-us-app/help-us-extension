import 'package:hive_flutter/hive_flutter.dart';

class DB {
  String user = 'user';
  String appName = 'help_us_app';

  init() async {
    await Hive.initFlutter();
    await Hive.openBox(appName);
  }

  getHiveBox() {
    return Hive.box(appName);
  }

  getUser() {
    Box box = getHiveBox();
    return box.get(user);
  }

  setUser(String userId) {
    Box box = getHiveBox();
    box.put(user, userId);
  }

  clearUser() {
    Box box = getHiveBox();
    box.delete(user);
  }
}
