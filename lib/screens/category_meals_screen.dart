import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_widget.dart';

import '../models/meal.dart';

class CategoryMeals extends StatefulWidget {
  // final String id;
  // final String title;
  // CategoryMeals(this.id, this.title);

  static const routeName = '/category_meals';
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
  final List<Meal> filterdMealList;
  CategoryMeals(
      {this.isGlutenFree,
      this.isLactoseFree,
      this.isVegan,
      this.isVegetarian,
      this.filterdMealList});

  @override
  _CategoryMealsState createState() => _CategoryMealsState();
}

class _CategoryMealsState extends State<CategoryMeals> {
  Map<String, Object> routeArgs;
  List<Meal> categoryList;

  @override
  void didChangeDependencies() {
    routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    final String id = routeArgs['id'];
    categoryList = widget.filterdMealList.where((meal) {
      return meal.categories.contains(id);
    }).toList();
    super.didChangeDependencies();
  }

  void removeMeal(String id) {
    setState(() {
      categoryList.removeWhere((element) => element.id == id);
    });
  }

  @override
  void initState() {
    print('is gluten free : ${widget.isGlutenFree}');
    print('is Vegan : ${widget.isVegan}');
    print('is Vegetarian : ${widget.isVegetarian}');
    print('is Lactose Free : ${widget.isLactoseFree}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: routeArgs['color'],
        iconTheme: Theme.of(context).iconTheme,
        title: Text(routeArgs['title']),
      ),
      body: ListView.builder(
        itemBuilder: (cntx, index) {
          return MealItem(
              categoryList.elementAt(index), routeArgs['color'], removeMeal);
        },
        itemCount: categoryList.length,
      ),
    );
  }
}
