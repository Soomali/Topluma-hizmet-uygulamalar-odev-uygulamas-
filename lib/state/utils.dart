part of 'ui_state.dart';

List<Food> createFoodPair({List<Food>? before}) {
  final isHealthy = random.nextBool();
  var list = [Food.random(isHealthy), Food.random(!isHealthy)];
  if (before != null) {
    final mapped = before.map((e) => e.name);
    while (
        mapped.contains(list.first.name) || mapped.contains(list.last.name)) {
      log('aborting same food choice');
      list = [Food.random(isHealthy), Food.random(!isHealthy)];
    }
  }
  return list;
}
