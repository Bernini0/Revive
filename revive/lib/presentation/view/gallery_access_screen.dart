import 'package:flutter/material.dart';

import '../widgets/gallery_access_screen_widgets/give_access_later.dart';
import '../widgets/gallery_access_screen_widgets/shimmer_images_widget.dart';
import '../widgets/gallery_access_screen_widgets/text_btn_widget.dart';

class GalleryAccessScreen extends StatelessWidget {
  const GalleryAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShimmerImages(),
            Spacer(flex: 2),
            TextButtonsWidget(),
            GiveAccessLater(),
            Spacer()
          ],
        ),
      ),
    );
  }
}
