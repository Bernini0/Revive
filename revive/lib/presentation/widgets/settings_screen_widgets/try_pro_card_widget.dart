import 'package:flutter/material.dart';
import 'package:revive/presentation/view/payment_screen.dart';
import 'package:provider/provider.dart';
import 'package:revive/model/subscription_purchases.dart';

import '../../../utils/constants.dart';

class TryProCard extends StatelessWidget {
  const TryProCard({super.key});

  @override
  Widget build(BuildContext context) {
    var subs = context.watch<SubscriptionPurchases>();
    return Container(
      height: 200,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Revive Pro',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 15,
                  ),
                  Text(
                    ' Unlimited Access',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 15,
                  ),
                  Text(
                    ' Multiple Results',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 15,
                  ),
                  Text(
                    ' No Ads',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 15,
                  ),
                  Text(
                    ' Free Trial',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    subs.loadPurchases();
                    return PaymentScreen();
                  }));
                },
                child: Container(
                  width: 150,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Try Pro Now',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              )
            ],
          ),
          Image(image: AssetImage('assets/images/Group.png'))
        ],
      ),
    );
  }
}
