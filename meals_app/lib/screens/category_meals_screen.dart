import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../widgets/main_drawer.dart';
import '../widgets/meal_item.dart';
import '../data/dummy_data.dart';

class CategoryMealsScreen extends StatefulWidget {
  //variables
  static const routeName = '/category-meals-screen';
  final List<Meal> availableMeals;
  final Function isMealFavourite;

  CategoryMealsScreen(this.availableMeals, this.isMealFavourite);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  void selectCategory(
      BuildContext context, String id, Color color, String title) {
    Navigator.of(context).pushReplacementNamed(
      CategoryMealsScreen.routeName,
      arguments: {
        'id': id,
        'color': color,
        'title': title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final categoryTitle = routeArgs['title'];
    final Color categoryColor = routeArgs['color'];
    final categoryid = routeArgs['id'];
    final categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryid);
    }).toList();

    final currentCategoryIndex = DUMMY_CATEGORIES.indexWhere((cat) {
      return categoryid == cat.id;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
        backgroundColor: categoryColor,
        actions: <Widget>[
          currentCategoryIndex == 0
              ? Container(height: 0, width: 0)
              : IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => selectCategory(
                      context,
                      DUMMY_CATEGORIES[currentCategoryIndex - 1].id,
                      DUMMY_CATEGORIES[currentCategoryIndex - 1].color,
                      DUMMY_CATEGORIES[currentCategoryIndex - 1].title)),
          SizedBox(width: 20),
          currentCategoryIndex == (DUMMY_CATEGORIES.length - 1)
              ? Container(height: 0, width: 0)
              : IconButton(
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () => selectCategory(
                      context,
                      DUMMY_CATEGORIES[currentCategoryIndex + 1].id,
                      DUMMY_CATEGORIES[currentCategoryIndex + 1].color,
                      DUMMY_CATEGORIES[currentCategoryIndex + 1].title)),
          SizedBox(width: 10),
        ],
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeals[index].id,
            title: categoryMeals[index].title,
            imageUrl: categoryMeals[index].imageUrl,
            duration: categoryMeals[index].duration,
            affordability: categoryMeals[index].affordability,
            complexity: categoryMeals[index].complexity,
            textGradientColor: categoryColor,
            isMealFavourite: widget.isMealFavourite,
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
