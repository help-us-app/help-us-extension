import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:help_us_extension/objects/item.dart';

class CartParser {
  static List<Item> parseAmazonCart(String page) {
    BeautifulSoup bs = BeautifulSoup(page);
    List<Item> items = [];
    var listItems = bs.findAll('div', class_: 'a-row sc-list-item');

    for (int i = 0; i < listItems.length; i++) {
      var listItem = listItems[i];
      items.add(Item(
        title: listItem.find('span', class_: 'sc-product-title').string.trim(),
        price: listItem.find('span', class_: 'sc-product-price').string.trim(),
        productImage:
            listItem.find('img', class_: 'sc-product-image').attributes['src'],
        productLink:
            listItem.find('a', class_: 'sc-product-link').attributes['href'],
        quantity: listItem.attributes['data-quantity'],
      ));
    }
    return items;
  }
}
