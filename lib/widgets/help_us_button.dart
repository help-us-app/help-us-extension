import 'package:flutter/material.dart';

class HelpUsButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const HelpUsButton({
    @required this.buttonText,
    @required this.buttonColor,
    this.textColor = Colors.white,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    bool cond = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onPressed,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 49,
            color: cond ? Colors.white : buttonColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonText != null
                      ? Text(
                          buttonText,
                          style: Theme.of(context).textTheme.headline6.copyWith(
                              color: cond ? buttonColor : Colors.white,
                              fontWeight: FontWeight.bold),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
