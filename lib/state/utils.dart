part of 'ui_state.dart';

List<Food> createFoodPair() {
  final isHealthy = random.nextBool();
  return [Food.random(isHealthy), Food.random(!isHealthy)];
}
