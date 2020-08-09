import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

import '../widgets/main_drawer.dart';
import './favourites_screen.dart';
import './categories_screen.dart';

class TabsScreen extends StatefulWidget {
  int _recievedSelectedPageIndex;
  List<Meal> favouriteMeals;
  Function isFavourite;
  static const routeName = "tabs-screen";

  TabsScreen(@required this._recievedSelectedPageIndex, @required this.favouriteMeals, @required this.isFavourite);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  //variables
  List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      CategoriesScreen(),
      FavouritesScreen(widget.favouriteMeals, widget.isFavourite),
    ];
    super.initState();
  }

  //functions

  //widgets
  @override
  Widget build(BuildContext context) {
    void _selectPage(int index) {
      setState(() {
        widget._recievedSelectedPageIndex = index;
      });
    }

    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Daily Meals"),
        ),
        drawer: MainDrawer(),
        body: _pages[widget._recievedSelectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.white,
          selectedItemColor: Theme.of(context).accentColor,
          currentIndex: widget._recievedSelectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.category),
              title: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star),
              title: Text(
                "Favourites",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
