import 'package:flutter_test/flutter_test.dart';

class StringCalculator {
  int _callCount = 0;

  int add(String numbers) {
    _callCount++;
    if (numbers.trim().isEmpty) {
      return 0;
    }

    String delimiterPattern = r'[,\n]';

    // Check if a delimiter is defined at the start of the string
    if (numbers.startsWith('//')) {
      int newlineIndex = numbers.indexOf('\n');
      if (newlineIndex != -1) {
        String customDelimiter = numbers.substring(2, newlineIndex);
        delimiterPattern = RegExp.escape(customDelimiter);
        numbers = numbers.substring(newlineIndex + 1);
      }
    }

    List<int> numbersList = numbers
        .split(RegExp(delimiterPattern))
        .map(int.parse)
        .toList();

    List<int> negatives = numbersList.where((n) => n < 0).toList();
    if (negatives.isNotEmpty) {
      throw Exception("Negatives not allowed: ${negatives.join(', ')}");
    }

    return numbersList.isEmpty ? 0 : numbersList.reduce((a, b) => a + b);
  }

  int getCalledCount() {
    return _callCount;
  }
}

void main() {
  test('returns 0 for empty string', () {
    final calc = StringCalculator();
    expect(calc.add(""), 0);
  });

  test('sums comma separated numbers', () {
    final calc = StringCalculator();
    expect(calc.add("1,2,3"), 6);
  });

  test('handles newlines as delimiters', () {
    final calc = StringCalculator();
    expect(calc.add("1\n2,3"), 6);
  });

  test('supports custom delimiter', () {
    final calc = StringCalculator();
    expect(calc.add("//;\n1;2;3"), 6);
  });

  test('throws on negatives and shows all of them', () {
    final calc = StringCalculator();
    expect(
      () => calc.add("//;\n-1;-2;-3"),
      throwsA(predicate((e) =>
          e is Exception &&
          e.toString().contains("Negatives not allowed: -1, -2, -3"))),
    );
  });

  test('tracks how many times add() was called', () {
    final calc = StringCalculator();
    expect(calc.getCalledCount(), 0);
    calc.add("1,2");
    calc.add("3,4");
    expect(calc.getCalledCount(), 2);
  });
}
