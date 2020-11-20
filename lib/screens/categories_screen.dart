import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/screens/settings_screen.dart';

import '../dummy_data.dart';
import '../widgets/category_widget.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class CategoriesScreen extends StatelessWidget {
  Widget widthContentBuilder(double width) {
    if (width < 500)
      return SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1),
          delegate: SliverChildListDelegate(
            DUMMY_CATEGORIES
                .map((e) => CategoryItem(e.id, e.title, e.color, e.imagePath))
                .toList(),
          ),
        ),
      );
    else
      return SliverPadding(
        padding: EdgeInsets.all(10),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3 / 2),
          delegate: SliverChildListDelegate(
            DUMMY_CATEGORIES
                .map((e) => CategoryItem(e.id, e.title, e.color, e.imagePath))
                .toList(),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final title = 'Meals App';
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ScrollConfiguration(
          behavior: MyBehavior(),
          child: CustomScrollView(slivers: [
            SliverAppBar(
              elevation: 0,
              floating: true,
              title: Text(title),
              iconTheme: Theme.of(context).iconTheme,
              actions: [
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    Navigator.of(context).pushNamed(FavoriteScreen.routeName,
                        arguments: {'id': 'mp'});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Navigator.of(context).push(PageRouteBuilder(
                    //   pageBuilder: (context, animation, secondaryAnimation) =>
                    //       SettingsScreen.empty(),
                    //   transitionsBuilder:
                    //       (context, animation, secondaryAnimation, child) {
                    //     var begin = Offset(1.0, 0.0);
                    //     var end = Offset.zero;
                    //     var curve = Curves.ease;

                    //     var tween = Tween(begin: begin, end: end)
                    //         .chain(CurveTween(curve: curve));

                    //     return SlideTransition(
                    //       position: animation.drive(tween),
                    //       child: child,
                    //     );
                    //   },
                    // ));
                    Navigator.of(context).pushNamed(SettingsScreen.routeName);
                  },
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
            widthContentBuilder(width),
          ]),
        ),
      ),
    );
  }
}
