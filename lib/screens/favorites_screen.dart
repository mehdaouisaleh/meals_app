import 'dart:io';

import '../widgets/meal_widget.dart';

import '../dummy_data.dart';
import '../models/meal.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavoriteScreen extends StatefulWidget {
  static const String routeName = '/favorites_screen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Meal> categoryList = [];

  Future<Box<E>> getOpenBox<E>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return Hive.openBox<E>(boxName);
    }

    return Hive.box<E>(boxName);
  }

  Box favoriteBox;
  int length = 0;
  final List<String> favs = [];
  @override
  void initState() {
    super.initState();
    getOpenBox('favorites');
    asyncMethode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void removeMeal(String id) {
    setState(() {
      categoryList.removeWhere((element) => element.id == id);
    });
  }

  asyncMethode() {
    favoriteBox = Hive.box('favorites');
    length = favoriteBox.length;
    for (int i = 0; i < length; i++) {
      for (var meal in DUMMY_MEALS.toList()) {
        if (meal.id == favoriteBox.getAt(i)) {
          categoryList.add(meal);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Map routeArgs = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: ListView.builder(
        itemBuilder: (cntx, index) {
          return MealItem(
              categoryList.elementAt(index), Colors.red, removeMeal);
        },
        itemCount: categoryList.length,
      ),
    );
  }
}
