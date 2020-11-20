import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/meal.dart';
import 'package:hive/hive.dart';

class MealDetails extends StatefulWidget {
  static const routeName = '/meal_details';

  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  Future<Box<E>> getOpenBox<E>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return Hive.openBox<E>(boxName);
    }

    return Hive.box<E>(boxName);
  }

  Meal meal;
  Color color;
  Box favoriteBox;
  bool isFav = false;
  Icon fav_icon = Icon(Icons.favorite_border);

  String get complexityText {
    switch (meal.complexity) {
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

  String get afodabilityText {
    switch (meal.affordability) {
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

  @override
  void initState() {
    super.initState();
    getOpenBox('favorites');
    favoriteBox = Hive.box('favorites');
  }

  void favMeal() {
    setState(() {
      if (isFav) {
        isFav = false;

        favoriteBox.delete(meal.id);
        fav_icon = Icon(Icons.favorite_border);
      } else {
        isFav = true;

        favoriteBox.put(meal.id, meal.id);
        fav_icon = Icon(Icons.favorite);
      }
    });
  }

  Widget iconBuilder() {
    if (favoriteBox.containsKey(meal.id)) {
      setState(() {
        fav_icon = Icon(Icons.favorite);
        isFav = true;
      });
      return IconButton(
        icon: fav_icon,
        color: Colors.white,
        onPressed: () {
          favMeal();
          HapticFeedback.heavyImpact();
        },
        tooltip: 'Favorite',
      );
    } else {
      setState(() {
        fav_icon = Icon(Icons.favorite_border);
        isFav = false;
      });
      return IconButton(
        icon: fav_icon,
        color: Colors.white,
        onPressed: () {
          favMeal();
          HapticFeedback.heavyImpact();
        },
        tooltip: 'Favorite',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    meal = routeArgs['meal'];
    color = routeArgs['color'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: iconBuilder(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    Navigator.of(context).pop(meal.id);
                  },
                  tooltip: 'Delete',
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.white70,
                  ),
                ),
              )
            ],
            backgroundColor: color,
            expandedHeight: 200.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.network(
                        meal.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                Colors.grey.withOpacity(0.0),
                                Colors.black.withOpacity(.8),
                              ],
                              stops: [
                                0.0,
                                1.0
                              ])),
                    ),
                  ],
                )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 16, right: 20, left: 20),
              child: Container(
                child: Text(
                  meal.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, bottom: 16, right: 20, left: 20),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.timer,
                        color: color,
                      ),
                    ),
                    Text(
                      "Duration: ${meal.duration} minutes",
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        Icons.attach_money,
                        color: color,
                      ),
                    ),
                    Text(
                      "Afordabilty: $afodabilityText",
                      style: TextStyle(fontSize: 16, color: color),
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
                        color: color,
                      ),
                    ),
                    Text(
                      "Complexity: $complexityText",
                      style: TextStyle(fontSize: 16, color: color),
                    ),
                  ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' Ingrediants :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: meal.ingredients
                        .map((e) => Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      "${e}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(.36),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            )))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          ' Steps :',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                        ))),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: meal.steps.asMap().entries.map((e) {
                      int index = e.key + 1;

                      return Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "$index- ${e.value}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black.withOpacity(.36),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    }).toList(),
                  ),
                ),
              ]),
            ),
          ]))
        ],
      ),
    );
  }
}
