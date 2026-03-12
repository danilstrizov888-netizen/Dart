import 'dart:math';

class MathProcessor {
  final List<double> numbers;
  MathProcessor(this.numbers);
  List<double> process(double Function(double) handler) {
    return numbers.map(handler).toList();
  }

  static List<double> getRandomNumbers(
    int count, {
    double min = 0.0,
    double max = 1.0,
  }) {
    if (count <= 0) return [];
    final random = Random();
    return List.generate(count, (_) => min + random.nextDouble() * (max - min));
  }
}

void main() {
  final randomNumbers = MathProcessor.getRandomNumbers(5, min: 1.0, max: 10.0);
  print('Сгенерированные числа: $randomNumbers');
  final processor = MathProcessor(randomNumbers);
  double square(double x) => x * x;
  final squares = processor.process(square);
  print('Квадраты чисел: $squares');
  final rounded = processor.process((x) => x.roundToDouble());
  print('Округлённые значения: $rounded');
}
