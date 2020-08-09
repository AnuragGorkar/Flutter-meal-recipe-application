import "package:flutter/material.dart";

import '../widgets/main_drawer.dart';
import "../data/dummy_data.dart";

class MealDetailScreen extends StatelessWidget {
  //variables
  static const routeName = '/meal-detail-screen';
  final Function toggleFavourite;
  final Function isMealFavourite;

  //functions
  MealDetailScreen(this.toggleFavourite, this.isMealFavourite);

  //widgets
  Widget buildSectionTitle(
      BuildContext context, String text, Color pageThemeColor) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
          color: pageThemeColor,
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildContainerTitle(
      BuildContext context, Widget ListContents, Color pageThemeColor) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: new BoxDecoration(
        border: Border.all(
          color: pageThemeColor,
          width: 3,
        ),
        borderRadius: new BorderRadius.circular(15.0),
      ),
      height: 200,
      width: 325,
      child: ListContents,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final mealId = routeArgs["id"];
    final Color pageThemeColor = routeArgs["pageThemeColor"];
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
        backgroundColor: pageThemeColor,
      ),
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              decoration: new BoxDecoration(
                border: Border.all(
                  color: pageThemeColor,
                  width: 4,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(11),
                  bottomRight: Radius.circular(11),
                ),
                child: Image.network(
                  selectedMeal.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  buildSectionTitle(context, "Ingredients", pageThemeColor),
                  buildContainerTitle(
                      context,
                      ListView.builder(
                        itemCount: selectedMeal.ingredients.length,
                        itemBuilder: (context, index) => Card(
                          child: Text(
                            selectedMeal.ingredients[index],
                            style: TextStyle(
                              fontSize: 17,
                              color: pageThemeColor,
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      pageThemeColor),
                  buildSectionTitle(context, "Steps", pageThemeColor),
                  buildContainerTitle(
                      context,
                      ListView.builder(
                        itemCount: selectedMeal.steps.length,
                        itemBuilder: (context, index) => Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text("# ${index + 1}",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'RobotoCondensed',
                                      fontWeight: FontWeight.w500,
                                    )),
                                backgroundColor: pageThemeColor,
                                radius: 18,
                              ),
                              title: Text(
                                selectedMeal.steps[index],
                                style: TextStyle(
                                  fontSize: 17,
                                  color: pageThemeColor,
                                  fontFamily: 'RobotoCondensed',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Divider(
                              color: pageThemeColor,
                            ),
                          ],
                        ),
                      ),
                      pageThemeColor),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isMealFavourite(mealId) ? Icons.star : Icons.star_border, color: Colors.white,),
        onPressed:() => toggleFavourite(mealId),
        backgroundColor: pageThemeColor,
      ),
    );
  }
}
