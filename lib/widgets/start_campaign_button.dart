import 'package:flutter/material.dart';
import 'package:help_us_extension/widgets/two_tone_text.dart';

class StartCampaignButton extends StatelessWidget {
  final VoidCallback onPressed;
  const StartCampaignButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 49,
              child: Stack(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "https://source.unsplash.com/random/?nature",
                        fit: BoxFit.cover,
                      )),
                  // Add container with blur effect
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  const Center(
                      child: TwoToneText(
                    tag: "start_campaign_text",
                    firstText: "Make a ",
                    secondText: "Wishlist",
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
