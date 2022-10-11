import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static String routeName = '/meal-detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetailScreen(this.toggleFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
  }

  Widget buildContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child
      );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((item) => item.id == mealId);
    return  Scaffold(
      appBar: AppBar(
        title: Text('${meal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl, 
                fit: BoxFit.cover
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, idx) => Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5, 
                    horizontal: 10
                  ),
                  child: Text(meal.ingredients[idx]),
                )
              ),
              itemCount: meal.ingredients.length,
            )),
            buildSectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, idx) => Column(
                children: [
                    ListTile(
                    leading: CircleAvatar(
                      child: Text('#${idx + 1}')
                    ),
                    title: Text(
                      meal.steps[idx],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const Divider()
                ]
              ),
              itemCount: meal.steps.length,
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border
        ),
        onPressed: () {
          toggleFavorite(mealId);
        },
      ),
    );
  }
}