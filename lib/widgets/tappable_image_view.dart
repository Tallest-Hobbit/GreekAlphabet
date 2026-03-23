import 'package:flutter/material.dart';

class TappableImageView extends StatelessWidget {
  final String imagePath;
  final ValueChanged<bool> onTapHalf;

  const TappableImageView({
    super.key,
    required this.imagePath,
    required this.onTapHalf,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            final tapY = details.localPosition.dy;
            final isTopHalf = tapY < constraints.maxHeight / 2;
            onTapHalf(isTopHalf);
          },
          child: SizedBox.expand(
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}