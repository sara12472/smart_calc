import 'dart:math';

class LoanCalculatorController {
  late double loanAmount;
  late double interestRate;
  late double loanTerm;
  late String frequency;

  LoanCalculatorController({
    required this.loanAmount,
    required this.interestRate,
    required this.loanTerm,
    required this.frequency,
  });

  /// Calculate number of payments
  int getTotalPayments() {
    if (frequency.toLowerCase() == "monthly") {
      return (loanTerm * 12).toInt();
    } else {
      return loanTerm.toInt(); // yearly
    }
  }

  /// Calculate periodic interest rate
  double getPeriodicInterestRate() {
    if (frequency.toLowerCase() == "monthly") {
      return (interestRate / 100) / 12;
    } else {
      return (interestRate / 100); // yearly
    }
  }

  /// Calculate EMI (payment per month or year)
  double calculatePayment() {
    int n = getTotalPayments();
    double r = getPeriodicInterestRate();

    if (r == 0) {
      return loanAmount / n; // Agar interest rate 0 ho
    }

    double payment = loanAmount * r * pow(1 + r, n) / (pow(1 + r, n) - 1);

    return payment;
  }

  /// Calculate total payable amount
  double calculateTotalPayment() {
    return calculatePayment() * getTotalPayments();
  }

  /// Calculate total interest
  double calculateTotalInterest() {
    return calculateTotalPayment() - loanAmount;
  }
}
