import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/relative_size_generator.dart';
import '../utils/strings.dart';

class LocationCard extends StatelessWidget {
  final String title, description, url;
  final bool selected;
  final VoidCallback onTap;
  const LocationCard(
      {Key key,
      this.title,
      this.description,
      this.url,
      this.onTap,
      this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(
        15.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          borderOnForeground: true,
          color: selected ? AppColors.primary : null,
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
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    url,
                    height: 80,
                    width: 80,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                    width: RelativeSizeGenerator.generate(
                        context, 0.6, Strings.width),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        if (description != null)
                          Text(
                            description,
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
