import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  static const routeName = 'filters-screen';
  final List<Meal> _favouriteMeals;
  final Function isFavourite;

  FavouritesScreen(this._favouriteMeals, this.isFavourite);
  
  @override
  Widget build(BuildContext context) {
    if(_favouriteMeals.isEmpty){
    return Center(child: Text("No favourites added yet!!! "),);
    }
    else
    return ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: _favouriteMeals[index].id,
            title: _favouriteMeals[index].title,
            imageUrl: _favouriteMeals[index].imageUrl,
            duration: _favouriteMeals[index].duration,
            affordability: _favouriteMeals[index].affordability,
            complexity: _favouriteMeals[index].complexity,
            textGradientColor: Theme.of(context).primaryColor,
            isMealFavourite: isFavourite,
          );
        },
        itemCount: _favouriteMeals.length,
      );
  }
}