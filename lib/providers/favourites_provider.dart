import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavMealsNotifier extends StateNotifier<List<Meal>> {
  FavMealsNotifier() : super([]);

  void toggleFavMeal(Meal meal) {
    final isFav = state.contains(meal);

    if (isFav) {
      state = state.where((element) => element.id == meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

final favMealsProvider =
    StateNotifierProvider<FavMealsNotifier, List<Meal>>((ref) {
  return FavMealsNotifier();
});
