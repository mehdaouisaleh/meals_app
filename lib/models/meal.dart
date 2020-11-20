import 'package:flutter/foundation.dart';

enum Affordability { Affordable, Pricey, Luxurious }
enum Complexity { Simple, Challenging, Hard }

class Meal {
  final String id;
  final String title;
  final String imageUrl;
  final double duration;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  final List<String> categories;
  final List<String> ingredients;
  final List<String> steps;
  final Affordability affordability;
  final Complexity complexity;
  const Meal(
      {@required this.id,
      @required this.title,
      @required this.duration,
      @required this.categories,
      @required this.imageUrl,
      @required this.ingredients,
      @required this.steps,
      @required this.isVegan,
      @required this.isGlutenFree,
      @required this.isLactoseFree,
      @required this.isVegetarian,
      @required this.affordability,
      @required this.complexity});
}
