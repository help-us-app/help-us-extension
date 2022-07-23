import 'package:flutter/material.dart';

import '../pages/loading_page.dart';
import 'gradient_background.dart';

class CustomScrollBody extends StatelessWidget {
  final List<Widget> slivers;
  final bool isLoading;
  const CustomScrollBody({Key key, this.slivers, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const GradientBackground(),
        CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: slivers,
        ),
        if (isLoading) const LoadingPage(),
      ],
    );
  }
}
