import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'close_btn_widget.dart';
import 'enhance_btn_widget.dart';

class ImgCardWidget extends StatelessWidget {
  ImgCardWidget({
    super.key,
    required this.image,
    required this.onTap,
  });

  ImageProvider image;
  var onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: kVerticalPadding*4,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: kVerticalPadding),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Hero(
                            tag: 'hero_img',
                            child: Image(
                                image: image,
                                fit: BoxFit.cover
                            ),
                          ),
                          CloseBtnWidget(),
                        ],
                      )
                  ),
                ),
                EnhanceBtnWidget(
                  image: image,
                  onTap: onTap,
                ),
              ],
            )
        )
    );
  }
}
