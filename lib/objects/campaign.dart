import 'package:help_us_extension/objects/user.dart';

import 'item.dart';

class Campaign {
  int id;
  String name;
  User user;
  String description;
  List<Item> items;

  Campaign({this.user, this.description, this.items, this.id,this.name});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    user = json['User'] != null ? User.fromJson(json['User']) : null;
    description = json['description'];
    if (json['items'] != null) {
      items = <Item>[];
      json['items'].forEach((v) {
        items.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['User'] = user.toJson();
    }
    data['name'] = name;
    data['description'] = description;
    if (items != null) {
      data['items'] = items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
