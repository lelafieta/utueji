class AppFuncionsUtilsHelper {
  static double calculateFundraisingPercentage(
      double? fundsRaised, double? fundraisingGoal) {
    if (fundsRaised == null ||
        fundraisingGoal == null ||
        fundraisingGoal == 0) {
      return 0.0;
    }

    double percentage = (fundsRaised / fundraisingGoal) * 100;
    return double.parse(percentage.toStringAsFixed(2));
  }
}
