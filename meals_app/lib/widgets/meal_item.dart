import 'package:flutter/material.dart';

import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatefulWidget {
  //variables
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Color textGradientColor;
  final Function isMealFavourite;

  //functions
  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
    @required this.textGradientColor,
    @required this.isMealFavourite,
  });

  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  String get complexityText {
    switch (widget.complexity) {
      case Complexity.Simple:
        return "Simple";
        break;
      case Complexity.Challenging:
        return "Challenging";
        break;
      case Complexity.Hard:
        return "Hard";
        break;
      default:
        return "Unknown";
    }
  }

  String get affordabilityText {
    switch (widget.affordability) {
      case Affordability.Affordable:
        return "Affordable";
        break;
      case Affordability.Luxurious:
        return "Luxurious";
        break;
      case Affordability.Pricey:
        return "Pricey";
        break;
      default:
        return "Unknown";
    }
  }

  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(
      MealDetailScreen.routeName,
      arguments: {
        "id": widget.id,
        "pageThemeColor": widget.textGradientColor,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[widget.textGradientColor, Colors.white],
    ).createShader(new Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));

    return InkWell(
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    widget.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Colors.black45,
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        foreground: new Paint()..shader = linearGradient,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.schedule,
                        color: widget.textGradientColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${widget.duration} min",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.textGradientColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.work,
                        color: widget.textGradientColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        complexityText,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.textGradientColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.attach_money,
                        color: widget.textGradientColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        affordabilityText,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.textGradientColor,
                        ),
                      ),
                    ],
                  ),
                  widget.isMealFavourite(widget.id) ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.star_border,
                        color: widget.textGradientColor,
                      ),
                    ],
                  ) : Container(height : 0, width : 0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
