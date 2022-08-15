import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.productLink,
    this.productImage,
    this.purchased,
    this.boughtBy
  });
  String id;
  String title;
  String price;
  String quantity;
  String productLink;
  String productImage;
  bool purchased;
  String boughtBy;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        productLink: json["product_link"],
        productImage: json["product_image"],
        purchased: json["purchased"],
        boughtBy: json["bought_by"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "quantity": quantity,
        "link": productLink,
        "thumbnail": productImage,
      };
}
