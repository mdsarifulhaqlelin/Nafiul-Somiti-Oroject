class EMICalculator {
  // Calculate Monthly EMI
  static double calculateMonthlyEMI(double principal, double annualInterestRate, int tenureMonths) {
    double monthlyRate = annualInterestRate / 12 / 100;
    double emi = (principal * monthlyRate * _pow(1 + monthlyRate, tenureMonths)) / 
                 (_pow(1 + monthlyRate, tenureMonths) - 1);
    return double.parse(emi.toStringAsFixed(2));
  }

  // Calculate Total Payable Amount
  static double calculateTotalPayable(double principal, double annualInterestRate, int tenureMonths) {
    double emi = calculateMonthlyEMI(principal, annualInterestRate, tenureMonths);
    return double.parse((emi * tenureMonths).toStringAsFixed(2));
  }

  // Helper function for power calculation
  static double _pow(double x, int n) {
    double result = 1.0;
    for (int i = 0; i < n; i++) {
      result *= x;
    }
    return result;
  }
}