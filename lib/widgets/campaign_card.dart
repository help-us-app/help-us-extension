import 'package:flutter/material.dart';
import 'package:help_us_extension/repositories/repository.dart';

import '../utils/app_colors.dart';

class CampaignCard extends StatelessWidget {
  final String title, description, id, image;
  final VoidCallback onTap;
  const CampaignCard(
      {Key key, this.title, this.description, this.id, this.onTap, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                    : Colors.grey[400],
                width: 0.2)),
        elevation: 0,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (image != null)
                Image.network(
                  "${Repository.directusUrl}assets/$image",
                  fit: BoxFit.cover,
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  width: 10,
                  height: 80,
                ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: title,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.headline6.color),
                        children: [
                          TextSpan(
                            text: " #$id",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary),
                          )
                        ],
                      ),
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
