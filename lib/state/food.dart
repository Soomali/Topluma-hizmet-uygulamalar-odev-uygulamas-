part of 'ui_state.dart';

const List<String> healthyFoods = [
  'armut',
  'brokoli',
  'elma',
  'havuc',
  'portakal_suyu',
  'salata',
  'badem',
  'yumurta',
  'balık',
  'biftek',
  'ceviz',
  'nohut',
  'süt',
];
const List<String> unhealthyFoods = [
  'baklava',
  'cips',
  'hamburger',
  'kola',
  'lolipop',
  'milkshake',
  'pizza',
  'margarin',
  'sosis',
  'salam',
  'donut',
  'lokma',
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
        name: foodName.replaceAll('_', ' '),
        photoPath: 'assets/${foodName}.jpeg');
  }
}

extension Pick on Random {
  T pick<T>(List<T> from) {
    return from[nextInt(from.length)];
  }
}
