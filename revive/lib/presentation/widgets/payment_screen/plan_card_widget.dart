import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import 'my_drp_down_widget.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: EdgeInsets.all(kDefaultPadding*2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(2,5)
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/images/1.png'),
                    fit: BoxFit.cover
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              kVerticalPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pro',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                MyDropdownButton(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kVerticalPadding),
            child: Text(
              'Unlock all our features, both on Mobile and on Desktop.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }
}
