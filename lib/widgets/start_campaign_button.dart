import 'package:flutter/material.dart';
import 'package:help_us_extension/widgets/start_campaign_text.dart';

import '../utils/remote_configurations.dart';

class StartCampaignButton extends StatelessWidget {
  final VoidCallback onPressed;
  const StartCampaignButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onPressed,

      child: Padding(
        padding: const EdgeInsets.only(top: 10,bottom: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 49,
            child: Stack(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      RemoteConfigurations.data["strings"]["start_campaign_button_image"],
                      fit: BoxFit.cover,
                    )),
                // Add container with blur effect
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                const Center(child: StartCampaignText()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
