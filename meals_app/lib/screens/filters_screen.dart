import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "filters-screen";

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegeterian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters["gluten"];
    _lactoseFree = widget.currentFilters["lactose"];
    _vegeterian = widget.currentFilters["vegeterian"];
    _vegan = widget.currentFilters["vegan"];
    super.initState();
  }

  Widget _switchListTile(String text, bool val, Function func) {
    return SwitchListTile(
        title: Text("$text"),
        subtitle: Text("Only include ${text} meals"),
        value: val,
        onChanged: func);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Filters"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 26,
                  ),
                  CircleAvatar(
                    child: IconButton(
                      icon: Icon(
                        Icons.save,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      onPressed: () {
                        final selectedFilters = {
                          "gluten": _glutenFree,
                          "lactose": _lactoseFree,
                          "vegan": _vegan,
                          "vegeterian": _vegeterian,
                        };
                        widget.saveFilters(selectedFilters);
                      },
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 24,
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust Your Meal Selection",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
                child: ListView(
              children: <Widget>[
                _switchListTile("Gluten-Free", _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                Divider(
                  color: Theme.of(context).primaryColor,
                  indent: 10,
                  thickness: 1,
                ),
                _switchListTile("Lactose-Free", _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                Divider(
                  color: Theme.of(context).primaryColor,
                  indent: 10,
                  thickness: 1,
                ),
                _switchListTile("Vegeterian", _vegeterian, (newValue) {
                  setState(() {
                    _vegeterian = newValue;
                  });
                }),
                Divider(
                  color: Theme.of(context).primaryColor,
                  indent: 10,
                  thickness: 1,
                ),
                _switchListTile("Vegan", _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                Divider(
                  color: Theme.of(context).primaryColor,
                  indent: 10,
                  thickness: 1,
                ),
              ],
            ))
          ],
        ));
  }
}
