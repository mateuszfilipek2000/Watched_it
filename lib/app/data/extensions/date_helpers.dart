extension leadingZeros on int {
  String addLeadingZeros(int numberOfTotalDigits) =>
      this.toString().padLeft(numberOfTotalDigits, '0');
}

extension dashedDate on DateTime {
  String getDashedDate() =>
      "${this.year}-${this.month.addLeadingZeros(2)}-${this.day.addLeadingZeros(2)}";
}
