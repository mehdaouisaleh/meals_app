import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings_screen';
  bool isGlutenFree;
  bool isVegan;
  bool isVegetarian;
  bool isLactoseFree;
  Function filterChange;
  SettingsScreen(
      {this.filterChange,
      this.isGlutenFree,
      this.isLactoseFree,
      this.isVegetarian,
      this.isVegan});
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool get isGlutenFree {
    return widget.isGlutenFree;
  }

  void isGlutenFreeSetter(bool value) {
    widget.isGlutenFree = value;
  }

  bool get isVegan {
    return widget.isVegan;
  }

  void isVeganSetter(bool value) {
    widget.isVegan = value;
  }

  bool get isVegetarian {
    return widget.isVegetarian;
  }

  void isVegetarianSetter(bool value) {
    widget.isVegetarian = value;
  }

  bool get isLactoseFree {
    return widget.isLactoseFree;
  }

  void isLactoseFreeSetter(bool value) {
    widget.isLactoseFree = value;
  }

  Widget listTileBuilder(
      String title, String subtitle, bool filter, Function changed) {
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        activeColor: Colors.red,
        value: filter,
        onChanged: (state) {
          changed();
          widget.filterChange(
              isVegetarian: isVegetarian,
              isGlutenFree: isGlutenFree,
              isVegan: isVegan,
              isLactoseFree: isLactoseFree);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Filters',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                )),
          ),
          Expanded(
              child: ListView(
            children: [
              listTileBuilder('Gluten Free', 'Only include Gluten free meals',
                  widget.isGlutenFree, () {
                setState(() {
                  isGlutenFreeSetter(!isGlutenFree);
                });
              }),
              listTileBuilder('Lactose Free', 'Only include Lactose free meals',
                  widget.isLactoseFree, () {
                setState(() {
                  isLactoseFreeSetter(!isLactoseFree);
                });
              }),
              listTileBuilder('Vegan', 'Only include Vegan meals', isVegan, () {
                setState(() {
                  isVeganSetter(!isVegan);
                });
              }),
              listTileBuilder(
                  'Vegetarian', 'Only include Vegetarian meals', isVegetarian,
                  () {
                setState(() {
                  isVegetarianSetter(!isVegetarian);
                });
              }),
            ],
          ))
        ],
      ),
    );
  }
}
