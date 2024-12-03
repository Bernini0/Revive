import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:revive/presentation/view/edited_screen.dart';
import 'dart:ui' as ui;
import '../../../utils/constants.dart';
import 'close_btn_widget.dart';

class LoadingImgCardWidget extends StatelessWidget {
  const LoadingImgCardWidget({super.key, required this.image});

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image(
                        image: image,
                        fit: BoxFit.cover,
                        height: size.height * 0.76,
                        width: size.width,
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                          child: Container(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      CloseBtnWidget(),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: kPrimary,
                      backgroundColor: Colors.black.withOpacity(0.5),
                    ),
                    SizedBox(
                        height:
                            10), // Add spacing between CircularProgressIndicator and Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/v1.svg',
                          fit: BoxFit.cover,
                        ),
                        Text(
                          'Some Text Goes Here',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        SvgPicture.asset(
                          'assets/icons/v2.svg',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
                vertical: kVerticalPadding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return EditedScreen(
                        image: image,
                      );
                    }),
                  );
                },
                child: Text(
                  'Enhancing your photo, this may take a few minutes.'
                  'Please hold tight.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
