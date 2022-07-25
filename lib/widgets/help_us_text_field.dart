import 'package:flutter/material.dart';

class HelpUsTextField extends StatelessWidget {
  final String value;
  final TextEditingController controller;
  final bool obscure;
  final String label;
  final int lines;
  final TextInputType type;
  final dynamic onChanged;
  final dynamic onSubmitted;
  final bool enabled;
  final IconData suffix, prefix;

  HelpUsTextField(
      {Key key,
      @required this.value,
      @required this.controller,
      @required this.obscure,
      this.suffix,
      this.onSubmitted,
      this.lines = 1,
      this.label,
      @required this.enabled,
      this.type,
      this.onChanged,
      this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        keyboardType: type,
        maxLines: lines,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        enabled: enabled,
        obscureText: obscure,
        decoration: InputDecoration(
            isCollapsed: false,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            labelText: value,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: Icon(suffix),
            prefixIcon: Icon(prefix),
            fillColor: Theme.of(context).cardColor
            // suffixIcon: Icon(AntDesign.car),
            ),
      ),
    );
  }
}
