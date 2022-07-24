import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import '../../objects/user.dart';
import '../../repositories/repository.dart';
import '../../utils/db.dart';

class WrapperBloc {
  BehaviorSubject<User> user = BehaviorSubject();
  DB db = DB();

  WrapperBloc() {
    updateUser();
  }

  updateUser() async {
    String userId = db.getUser();
    log('userId: $userId');
    if (userId != null) {
      User user = await Repository.getUserById(userId);
      if (user == null) {
        this.user.addError("no_user_found");
      }
      this.user.add(user);
    } else {
      user.addError("no_user_found");
    }
  }

  dispose() {
    user.close();
  }
}
