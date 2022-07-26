import 'package:flutter/material.dart';
import 'package:help_us_extension/objects/item.dart';
import 'package:help_us_extension/utils/price_formatter.dart';

class ProductRow extends StatelessWidget {
  final Item product;
  final VoidCallback onTap;
  final String hero;

  const ProductRow({
    @required this.product,
    @required this.onTap,
    this.hero,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        splashColor: Colors.transparent,
        onTap: onTap,
        child: Card(
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                15.0,
              ),
              side: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[200],
                  width: 0.2)),
          elevation: 0,
          shadowColor: Colors.grey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      product.productImage,
                      height: 76,
                      width: 76,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        product.title,
                        style: theme.textTheme.headline6,
                      ),
                    ),
                    Row(
                      children: [
                        PriceFormatter.numberString(
                            double.parse(product.price), context, 20.0),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
