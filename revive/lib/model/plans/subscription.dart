// Context class that uses the plans
import 'package:revive/model/plans/plan.dart';

class SubscriptionContext {
  late Plan plan;

  SubscriptionContext(this.plan);

  void displayPlanDetails() {
    print('Plan Duration: ${plan.getDuration()}');
    print('Price: \$${plan.getPrice()} per ${plan.getDuration()}');
  }
}
