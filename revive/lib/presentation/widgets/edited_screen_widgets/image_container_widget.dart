import 'package:flutter/material.dart';
import 'dart:io';

import 'package:photo_gallery/photo_gallery.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    required this.image,
  }) : super(key: key);

  final image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Hero(
        tag: 'hero_img',
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: image,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
