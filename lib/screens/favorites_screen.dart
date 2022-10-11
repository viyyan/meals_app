import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  List<Meal> favoriteMeals = [];

  FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
          child: Text('You have no favorites yet!'),
      );
    } else {
      return  ListView.builder(
        itemBuilder: (ctx, idx) {
          final meal = favoriteMeals[idx];
          return MealItem(
            id: meal.id,
            title: meal.title, 
            imageUrl: meal.imageUrl, 
            duration: meal.duration, 
            complexity: meal.complexity, 
            affordability: meal.affordability,
          );
        },
        itemCount: favoriteMeals.length,
      );
    }
  }
}