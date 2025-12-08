class Calculator {
  int sumAB(int a, int b) {
    final sum = a + b;
    if (sum > 10) {
      return 10;
    }
    return a + b;
  }
}
