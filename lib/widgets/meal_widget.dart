import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import '../models/meal.dart';

class MealItem extends StatefulWidget {
  final Meal meal;
  final Color color;
  final Function removeMeal;
  MealItem(this.meal, this.color,this.removeMeal);

  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
 
  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetails.routeName, arguments: {
      'meal': widget.meal,
      'color': widget.color
    }).then((value) => widget.removeMeal(value));
  }

  String get afodabilityText {
    switch (widget.meal.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
      case Affordability.Luxurious:
        return 'Luxurious';
      case Affordability.Pricey:
        return 'Pricey';
      default:
        return 'Unkown';
    }
  }

  String get complexityText {
    switch (widget.meal.complexity) {
      case Complexity.Challenging:
        return 'Challenging';
      case Complexity.Hard:
        return 'Hard';
      case Complexity.Simple:
        return 'Simple';
      default:
        return 'Unkown';
    }
  }

  Color icon_color = Colors.black54;
  @override
  Widget build(BuildContext context) {
    void isChanged(bool b) {
      if (b)
        setState(() {
          icon_color = widget.color;
        });
      else
        setState(() {
          icon_color = Colors.black54;
        });
    }

    return Theme(
      data: Theme.of(context).copyWith(accentColor: widget.color),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            InkWell(
              splashColor: widget.color.withOpacity(.5),
              onTap: () {
                selectMeal(context);
              },
              child: Stack(children: [
                Ink.image(
                  height: 200,
                  width: double.infinity,
                  image: NetworkImage(widget.meal.imageUrl),
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.grey.withOpacity(0.0),
                            Colors.white.withOpacity(.33),
                          ],
                          stops: [
                            0.0,
                            1.0
                          ])),
                ),
              ]),
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              onExpansionChanged: (b) {
                isChanged(b);
              },
              tilePadding:
                  EdgeInsets.only(top: 16, bottom: 0, right: 20, left: 20),
              title: Text(
                widget.meal.title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.fade,
              ),
              subtitle: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 8),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.timer,
                          color: icon_color,
                        ),
                      ),
                      Text(
                        "Duration: ${widget.meal.duration} mn",
                        style: TextStyle(fontSize: 16),
                      ),
                    ]),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 16, right: 20, left: 20),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.attach_money,
                            color: widget.color,
                          ),
                        ),
                        Text(
                          "Afordabilty: $afodabilityText",
                          style: TextStyle(fontSize: 16, color: widget.color),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.kitchen,
                            color: widget.color,
                          ),
                        ),
                        Text(
                          "Complexity: $complexityText",
                          style: TextStyle(fontSize: 16, color: widget.color),
                        ),
                      ]),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Container(
                    //     child: Align(
                    //         alignment: Alignment.centerLeft,
                    //         child: Text(
                    //           ' Ingrediants:',
                    //           style: TextStyle(
                    //               fontSize: 20,
                    //               fontWeight: FontWeight.normal,
                    //               color: Colors.black87),
                    //         ))),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   child: Column(
                    //     children: widget.meal.ingredients
                    //         .map((e) => Align(
                    //             alignment: Alignment.centerLeft,
                    //             child: Padding(
                    //               padding: const EdgeInsets.all(8.0),
                    //               child: Row(
                    //                 children: [
                    //                   Flexible(
                    //                     child: Text(
                    //                       "${e}",
                    //                       style: TextStyle(
                    //                           fontSize: 16,
                    //                           color:
                    //                               Colors.black.withOpacity(.36),
                    //                           fontWeight: FontWeight.bold),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             )))
                    //         .toList(),
                    //   ),
                    // ),
                  ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
