import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_list_item.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) toggleFavouriteMeal;

  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.toggleFavouriteMeal,
  });

  void _selectCard(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealDetailsScreen(
            meal: meal,
            toggleFavouriteMeal: toggleFavouriteMeal,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) {
        return MealListItem(
          meal: meals[index],
          onSelectMeal: _selectCard,
        );
      },
    );

    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
