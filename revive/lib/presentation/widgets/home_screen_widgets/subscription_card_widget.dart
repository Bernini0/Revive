import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class SubscriptionCardWidget extends StatelessWidget {
  var onTap;

  SubscriptionCardWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        color: kCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/card_img.png'),
                    fit: BoxFit.cover,
                  )),
            ),
          ),
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.all(kDefaultPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restore and Colorize Your Old Photos with AI',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '\n Your Old Memories Back to Life with Easy-to-Use Features and Seamless Sharing Options\n',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: kHorizontalPadding),
                      child: Container(
                        width: 120,
                        padding: EdgeInsets.symmetric(
                            horizontal: kHorizontalPadding / 2,
                            vertical: kDefaultPadding),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: InkWell(
                            child: Text(
                              'Try Now',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
              child: InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
