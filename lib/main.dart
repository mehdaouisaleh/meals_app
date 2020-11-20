import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import './screens/favorites_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/settings_screen.dart';
import './models/meal.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('favorites');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filtersList = {
    'isGlutenFree': false,
    'isVegan': false,
    'isVegetarian': false,
    'isLactoseFree': false
  };
  List<Meal> filterdMealList = DUMMY_MEALS.toList();

  void filterChange(
      {bool isGlutenFree,
      bool isVegan,
      bool isVegetarian,
      bool isLactoseFree}) {
    setState(() {
      filtersList['isGlutenFree'] = isGlutenFree;
      filtersList['isVegan'] = isVegan;
      filtersList['isVegetarian'] = isVegetarian;
      filtersList['isLactoseFree'] = isLactoseFree;
      filterdMealList = DUMMY_MEALS.where((element) {
        if (!element.isGlutenFree && filtersList['isGlutenFree']) {
          return false;
        }
        if (!element.isLactoseFree && filtersList['isLactoseFree']) {
          return false;
        }
        if (!element.isVegan && filtersList['isVegan']) {
          return false;
        }
        if (!element.isVegetarian && filtersList['isVegetarian']) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 0),
        iconTheme: IconThemeData(color: Colors.white),
        fontFamily: 'Barlow',
        primarySwatch: Colors.red,
        accentColor: Colors.white,
        primaryTextTheme: TextTheme(
          headline6:
              TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CategoriesScreen(),
      routes: {
        CategoryMeals.routeName: (_) => CategoryMeals(
              isGlutenFree: filtersList['isGlutenFree'],
              isLactoseFree: filtersList['isLactoseFree'],
              isVegan: filtersList['isVegan'],
              isVegetarian: filtersList['isVegetarian'],
              filterdMealList: filterdMealList,
            ),
        MealDetails.routeName: (_) => MealDetails(),
        // FavoriteScreen.routeName: (_) => FavoriteScreen(),
        //  SettingsScreen.routeName: (_) => SettingsScreen.function(filterChange),
      },
      onGenerateRoute: (settings) {
        if (settings.name == FavoriteScreen.routeName) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                FavoriteScreen(),
            settings: settings,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        } else if (settings.name == SettingsScreen.routeName) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                SettingsScreen(
              filterChange: filterChange,
              isGlutenFree: filtersList['isGlutenFree'],
              isLactoseFree: filtersList['isLactoseFree'],
              isVegan: filtersList['isVegan'],
              isVegetarian: filtersList['isVegetarian'],
            ),
            settings: settings,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        }
        return MaterialPageRoute(builder: (context) => CategoriesScreen());
      },
      onUnknownRoute: (_) {
        return MaterialPageRoute(builder: (_) => CategoriesScreen());
      },
    );
  }
}
