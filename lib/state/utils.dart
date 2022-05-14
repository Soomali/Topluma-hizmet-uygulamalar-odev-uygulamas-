import 'food.dart';

List<Food> createFoodPair() {
  final isHealthy = random.nextBool();
  return [Food.random(isHealthy), Food.random(!isHealthy)];
}
