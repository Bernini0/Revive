import 'package:flutter/material.dart';

import '../../../../utils/constants.dart';

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
    required this.text1,
    required this.text2
  });

  final text1, text2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height*0.3,
          decoration: gradientBoxDec,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kVerticalPadding*2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text2,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          child: Image(
            image: AssetImage('assets/images/Ellipse5.png'),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 100,
          child: Image(
            image: AssetImage('assets/images/Ellipse4.png'),
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
