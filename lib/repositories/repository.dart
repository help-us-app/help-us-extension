import 'dart:developer';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import '../objects/campaign.dart';
import '../objects/item.dart';
import '../objects/location.dart';
import '../objects/user.dart';

class Repository {
  static Dio dio = Dio();
  static String directusUrl = const String.fromEnvironment("DIRECTUS_URL");
  static String directusToken = const String.fromEnvironment("DIRECTUS_TOKEN");
  static String herokuUrl = const String.fromEnvironment("HEROKU_URL");
  static String herokuToken = const String.fromEnvironment("HEROKU_TOKEN");

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

  static createUser({User user}) async {
    try {
      Response response = await dio.post("${directusUrl}items/User",
          options: Options(headers: {"Authorization": "Bearer $directusToken"}),
          data: user == null ? {} : user.toJson());
      log("createUser");
      return User.fromJson(response.data["data"]);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static getLocations(String userId) async {
    try {
      Response response = await dio.get(
        "${herokuUrl}location?user_id=$userId",
        options: Options(headers: {"Authorization": "Bearer $herokuToken"}),
      );

      List<Location> locations = [];
      for (var location in response.data["result"]) {
        locations.add(Location.fromJson(location));
      }
      return locations;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static setLocation(String locationId, String userId) async {
    Response response = await dio.patch(
      "${directusUrl}items/User/$userId",
      options: Options(headers: {"Authorization": "Bearer $directusToken"}),
      data: {
        "location_id": locationId,
      },
    );
    log("setLocation");
    return User.fromJson(response.data["data"]);
  }

  static Future<String> createItem(Item item, String campaignId) async {
    try {
      var itemJson = item.toJson();
      itemJson["campaign_id"] = campaignId;
      Response response = await dio.post(
        "${directusUrl}items/Item",
        options: Options(headers: {"Authorization": "Bearer $directusToken"}),
        data: itemJson,
      );
      log("createItem");
      return response.data["data"]["id"];
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<bool> createCampaign(Campaign campaign) async {
    try {
      String imageId = await uploadImage(campaign.image);

      var response = await dio.post("${directusUrl}items/Campaign",
          options: Options(headers: {"Authorization": "Bearer $directusToken"}),
          data: {
            "name": campaign.name,
            "description": campaign.description,
            "location_id": campaign.locationId,
            "image": imageId,
          });
      String campaignId = response.data["data"]["id"];

      for (var item in campaign.items) {
        await createItem(item, campaignId);
      }

      log("createCampaign");
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static Future<bool> updateCampaign(Campaign campaign) async {
    try {
      String imageId = await uploadImage(campaign.completed);
      log("imageId: $imageId");

      await dio.patch("${directusUrl}items/Campaign/${campaign.id}",
          options: Options(headers: {"Authorization": "Bearer $directusToken"}),
          data: {
            "completed": imageId,
            "is_completed": true,
          });

      log("updateCampaign");
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  static uploadImage(Uint8List file) async {
    try {
      dynamic response = await dio.post("${directusUrl}files",
          data: FormData.fromMap({
            "file": MultipartFile.fromBytes(
              file,
              filename: "image",
              contentType: MediaType("image", "png"),
            )
          }),
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer $directusToken"
          }));
      return response.data["data"]['id'];
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static getCampaigns(String locationId) async {
    try {
      Response response = await dio.get(
        "${directusUrl}items/Campaign?filter[location_id][_eq]=$locationId",
        options: Options(headers: {"Authorization": "Bearer $directusToken"}),
      );
      log("getCampaigns");
      List<Campaign> campaigns = [];
      for (var campaign in response.data["data"]) {
        campaigns.add(Campaign.fromJson(campaign));
      }
      return campaigns;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static getItems(String campaignId) async {
    try {
      Response response = await dio.get(
        "${directusUrl}items/Item?filter[campaign_id][_eq]=$campaignId",
        options: Options(headers: {"Authorization": "Bearer $directusToken"}),
      );
      log("getItems");
      List<Item> items = [];
      for (var item in response.data["data"]) {
        items.add(Item(
          id: item["id"].toString(),
          title: item["title"],
          productLink: item["link"],
          productImage: item["thumbnail"],
          price: item["price"],
          purchased: item["purchased"],
          boughtBy: item["bought_by"],
        ));
      }
      return items;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static scrapeCart(String webpage, String url) async {
    try {
      Response response = await dio.post(
        "${herokuUrl}scrape",
        data: {"url": url, "body": webpage},
        options: Options(headers: {"Authorization": "Bearer $herokuToken"}),
      );
      log("scrapeCart");
      dynamic result = response.data["result"];
      List<Item> items = [];
      for (var item in result) {
        items.add(Item(
          title: item["title"],
          productLink: item["productLink"],
          productImage: item["productImage"],
          price: item["price"],
          quantity: item["quantity"],
        ));
      }
      return items;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
