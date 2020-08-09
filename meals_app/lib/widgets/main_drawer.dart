import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget ListTileBuilder(
      BuildContext context, IconData icon, String text, Function tapHandler) {
    return ListTile(
      leading: Stack(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            radius: 21,
          ),
          CircleAvatar(
            child: Icon(
              icon,
              size: 26,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).accentColor,
            radius: 20,
          ),
        ],
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: "RobotoCondensed",
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).accentColor,
          child: Text(
            "Cooking Up!",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          height: 10,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(
          height: 20,
        ),
        ListTileBuilder(
          context,
          Icons.restaurant,
          "Meal Categories",
          () {
            Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
          },
        ),
        Divider(),
        ListTileBuilder(
          context,
          Icons.star,
          "Favourites",
          () {
            Navigator.of(context).pushReplacementNamed("/");
          },
        ),
        Divider(),
        ListTileBuilder(
          context,
          Icons.settings,
          "Filters",
          () {
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          },
        ),
      ],
    ));
  }
}
