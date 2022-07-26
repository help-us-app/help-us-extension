import 'item.dart';

class Campaign {
  int id;
  String name;
  String user;
  dynamic image;
  String description;
  List<Item> items;

  Campaign(
      {this.user,
      this.description,
      this.items,
      this.id,
      this.name,
      this.image});

  Campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    user = json['User'];
    image = json['image'];
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
      data['User'] = user;
    }
    data['name'] = name;
    data['description'] = description;
    if (items != null) {
      data['items'] = items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
