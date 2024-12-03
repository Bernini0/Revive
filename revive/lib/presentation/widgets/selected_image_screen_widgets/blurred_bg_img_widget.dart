import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class BlurredBgImgWidget extends StatelessWidget {
  ImageProvider image;

  BlurredBgImgWidget({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image(
          image: image,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Adjust the sigma values for the desired blur effect
          child: Container(
            color: Colors.transparent, // This color won't be visible but is required for BackdropFilter to work
          ),
        ),
      ],
    );
  }
}
