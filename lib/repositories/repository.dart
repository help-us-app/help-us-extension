import 'dart:developer';

import 'package:dio/dio.dart';
import '../objects/user.dart';

class Repository {
  static Dio dio = Dio();
  static String directusUrl = "https://help-us.directus.app/";
  static String directusToken = "VjL2EY9ju8efp37w8ZUobcrcn99vL4ce";
  static String herokuUrl = "https://help-us-api.herokuapp.com/";
  static String herokuToken = "";

  static getUserById(String userId) async {
    try {
      Response response = await dio.get("${directusUrl}items/User/$userId",
          options:
              Options(headers: {"Authorization": "Bearer $directusToken"}));
      log("getUserById");
      return User.fromJson(response.data["data"]);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static createUser() async {
    try {
      Response response = await dio.post("${directusUrl}items/User",
          options: Options(headers: {"Authorization": "Bearer $directusToken"}),
          data: {});
      log("createUser");
      return User.fromJson(response.data["data"]);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
