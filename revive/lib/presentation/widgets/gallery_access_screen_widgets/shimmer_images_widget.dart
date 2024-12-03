import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerImages extends StatelessWidget {
  const ShimmerImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 8,
      child: Container(
        color: Colors.black.withOpacity(0.8),
        child: Shimmer(
          colorOpacity: 0.15,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Image(
                      image: AssetImage('assets/images/1.png'),
                      width: MediaQuery.of(context).size.width*0.5,
                      fit: BoxFit.cover,
                    ),
                    Image(
                      image:  AssetImage('assets/images/2.png'),
                      width: MediaQuery.of(context).size.width*0.5,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Image(
                  image:  AssetImage('assets/images/3.png'),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Image(
                      image:  AssetImage('assets/images/4.png'),
                      width: MediaQuery.of(context).size.width*0.5,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image(
                            image:  AssetImage('assets/images/5.png'),
                            width: MediaQuery.of(context).size.width*0.5,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Image(
                            image:  AssetImage('assets/images/6.png'),
                            width: MediaQuery.of(context).size.width*0.5,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}