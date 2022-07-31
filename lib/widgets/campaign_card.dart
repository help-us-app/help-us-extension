import 'package:flutter/material.dart';
import 'package:help_us_extension/repositories/repository.dart';

import '../utils/app_colors.dart';

class CampaignCard extends StatelessWidget {
  final String title, description, id, image;
  final VoidCallback onTap;
  final bool isCompleted;
  const CampaignCard(
      {Key key,
      this.title,
      this.description,
      this.id,
      this.onTap,
      this.image,
      this.isCompleted})
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
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            child: Container(
                              height: 20,
                              color: isCompleted
                                  ? AppColors.primary.withOpacity(0.2)
                                  : AppColors.red.withOpacity(0.2),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Center(
                                  child: Text(
                                    isCompleted ? 'Completed' : 'Not Completed',
                                    style: Theme.of(context)
                                        .textTheme
                                        .overline
                                        .copyWith(
                                            color: isCompleted
                                                ? AppColors.primary
                                                : AppColors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                  ),
                                ),
                              ),
                            ))),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        description,
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.grey),
                      ),
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
