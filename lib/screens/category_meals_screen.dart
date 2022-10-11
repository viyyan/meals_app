import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';



class CategoryMealsScreen extends StatefulWidget {
  static String routeName = '/category-meals';

  final List<Meal> avalaibleMeals;

  CategoryMealsScreen(this.avalaibleMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  List<Meal> categoryMeals = [];
  var _loadedInitData = false;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title']!;
      final categoryId = routeArgs['id'];
      categoryMeals = widget.avalaibleMeals.where(
        (item) => 
          item.categories.contains(categoryId)
      ).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      categoryMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, idx) {
          final meal = categoryMeals[idx];
          return MealItem(
            id: meal.id,
            title: meal.title, 
            imageUrl: meal.imageUrl, 
            duration: meal.duration, 
            complexity: meal.complexity, 
            affordability: meal.affordability,
            // removeItem: _removeMeal,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}