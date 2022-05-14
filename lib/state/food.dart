import 'dart:math';

const List<String> healthyFoods = [
  'armut',
  'brokoli',
  'elma',
  'havuc',
  'portakal suyu',
  'salata'
];
const List<String> unhealthyFoods = [
  'baklava',
  'cips',
  'hamburger',
  'kola',
  'lolipop',
  'milkshake',
  'pizza',
];
final Random random = Random();

class Food {
  bool isHealthy;
  String name;
  String photoPath;
  Food({required this.isHealthy, required this.name, required this.photoPath});
  factory Food.random(bool isHealthy) {
    final foodName =
        isHealthy ? random.pick(healthyFoods) : random.pick(unhealthyFoods);
    return Food(
        isHealthy: isHealthy,
        name: foodName,
        photoPath: 'assets/${foodName.replaceAll('_', ' ')}.jpeg');
  }
}

extension Pick on Random {
  T pick<T>(List<T> from) {
    return from[nextInt(from.length)];
  }
}
