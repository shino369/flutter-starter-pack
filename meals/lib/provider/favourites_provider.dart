import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavouritesNotifier extends StateNotifier<List<Meal>> {
  FavouritesNotifier() : super([]); // initial data

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouritesProvider = StateNotifierProvider<FavouritesNotifier, List<Meal>>((ref) {
  return FavouritesNotifier();
});
