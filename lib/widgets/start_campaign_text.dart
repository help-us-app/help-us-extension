import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/remote_configurations.dart';

class StartCampaignText extends StatelessWidget {
  const StartCampaignText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "start_campaign_text",
      child: RichText(
        text: TextSpan(
          text: RemoteConfigurations.data["strings"]["start_a"],
          style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 20, color: Theme.of(context).textTheme.headline6.color),
          children: [
            TextSpan(
              text: RemoteConfigurations.data["strings"]["campaign"],
              style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: AppColors.primary,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
