import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    this.title,
    this.price,
    this.quantity,
    this.productLink,
    this.productImage,
  });

  String title;
  String price;
  String quantity;
  String productLink;
  String productImage;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        productLink: json["product_link"],
        productImage: json["product_image"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "quantity": quantity,
        "link": productLink,
        "thumbnail": productImage,
      };
}
