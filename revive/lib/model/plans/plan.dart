// Plan interface
abstract class Plan {
  double getPrice();
  String getDuration();
}

// Concrete classes for different plans
class WeeklyLitePlan implements Plan {
  @override
  double getPrice() => 7.99;

  @override
  String getDuration() => '7 days';
}

class WeeklyProPlan implements Plan {
  @override
  double getPrice() => 9.99;

  @override
  String getDuration() => '7 days';
}

class MonthlyLitePlan implements Plan {
  @override
  double getPrice() => 15.99;

  @override
  String getDuration() => '30 days';
}

class MonthlyProPlan implements Plan {
  @override
  double getPrice() => 19.99;

  @override
  String getDuration() => '30 days';
}
