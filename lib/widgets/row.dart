import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/price_formatter.dart';

class ItemRow extends StatelessWidget {
  final String title, price, image;
  final VoidCallback onTap;
  final bool isPurchased;
  final String boughtBy;

  const ItemRow(
      {Key key,
      this.onTap,
      this.title,
      this.price,
      this.image,
      this.isPurchased,
      this.boughtBy})
      : super(key: key);

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
                  color:
                      Colors.grey[800],
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
                  child: Image.network(
                    image,
                    height: 76,
                    width: 76,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        style: theme.textTheme.headline6,
                      ),
                    ),
                    if (boughtBy != null)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            boughtBy,
                            style: theme.textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[500],
                                fontSize: 12),
                          )),
                    if (isPurchased != null)
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              child: Container(
                                height: 20,
                                color: isPurchased
                                    ? AppColors.primary.withOpacity(0.2)
                                    : AppColors.red.withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Center(
                                    child: Text(
                                      isPurchased
                                          ? 'Purchased'
                                          : 'Not Purchased',
                                      style: theme.textTheme.overline.copyWith(
                                          color: isPurchased
                                              ? AppColors.primary
                                              : AppColors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                              ))),
                    Row(
                      children: [
                        PriceFormatter.numberString(
                            double.parse(price.replaceAll("\$", "")),
                            context,
                            20.0),
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
