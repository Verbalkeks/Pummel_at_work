import 'package:flutter_test/flutter_test.dart';
import 'package:pummel_the_fish/data/models/calculator.dart';

void main() {
  late Calculator calculator;
  setUp(() {
    calculator = Calculator();
  });
  group("sumAB()", () {
    test("should return sum if sum < 10", () {
      // setup
      const int a = 2;
      const int b = 3;
      // act
      final result = calculator.sumAB(a, b);
      // expect
      expect(result, 5);
    });
    test("should return 10 if sum > 10", () {
      // setup
      const int a = 7;
      const int b = 8;
      // act
      final result = calculator.sumAB(a, b);
      // expect
      expect(result, 10);
    });
    test("should return sum if a and b negatives", () {
      // setup
      const int a = -5;
      const int b = -100;
      // act
      final result = calculator.sumAB(a, b);
      // expect
      expect(result, -105);
    });
    test("should return 10 if sum = 10", () {
      // setup
      const int a = -10;
      const int b = 20;
      // act
      final result = calculator.sumAB(a, b);
      // expect
      expect(result, 10);
    });
  });
}
