import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revive/model/subscription_purchases.dart';
import 'package:revive/presentation/widgets/landing_screen_widgets/start_button_widget.dart';
import 'package:revive/presentation/widgets/payment_screen/my_drp_down_widget.dart';
import 'package:revive/presentation/widgets/payment_screen/plan_card_widget.dart';
import 'package:revive/utils/constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool proChecked = false;
  late PageController _pageController;
  int initialPage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: .75,
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var subs = context.watch<SubscriptionPurchases>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Choose a plan',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.25,
              child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      initialPage = value;
                    });
                  },
                  controller: _pageController,
                  physics: ClampingScrollPhysics(),
                  itemCount: 2,
                  scrollBehavior: ScrollBehavior(),
                  itemBuilder: (context, index) => buildPlanCard(index)),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(kVerticalPadding),
              child: Container(
                height: 75,
                padding: EdgeInsets.symmetric(
                    vertical: kVerticalPadding, horizontal: kHorizontalPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Not Sure Yet?',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          'Enable Free Trial',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                    Checkbox(
                      activeColor: Colors.black,
                      value: proChecked,
                      // Replace with a boolean variable from your state
                      onChanged: (bool? newValue) {
                        setState(() {
                          proChecked =
                              newValue ?? false; // Update the state variable
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kVerticalPadding),
              child: StartButtonWidget(
                  text: 'Continue',
                  onTap: () {
                    print(
                        '${subs.products[1].productDetails.title} ${subs.products[1].productDetails.price}');
                    subs.buy(subs.products[0]);
                  }),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kVerticalPadding),
              child: Text(
                'BDT 1100/week',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kVerticalPadding),
              child: Text(
                'Renews automatically. Cancel anytime.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPlanCard(int index) => AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0;
          if (_pageController.position.haveDimensions) {
            value = index - _pageController.page!;
            value = (value).clamp(-1, 1);
          }
          double scale =
              1 - (value.abs() * 0.5); // Adjust the scale factor as desired

          return AnimatedOpacity(
            duration: Duration(milliseconds: 500),
            opacity: initialPage == index ? 1 : 0.25,
            child: Transform.scale(
              scale: scale,
              child: PlanCard(),
            ),
          );
        },
      );
}
