import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/constants.dart';

class TitleChooseImageOptionsWidget extends StatelessWidget {
  const TitleChooseImageOptionsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'All Photos',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            padding: EdgeInsets.all(kDefaultPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.22),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/icons/gallery.svg',
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.white,
                ),
                SvgPicture.asset(
                  'assets/icons/camera.svg',
                  height: 20,
                  width: 20,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}