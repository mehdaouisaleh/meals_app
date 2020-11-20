import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;
  final String imagePath;

  const Category({this.id, this.title, this.color = Colors.amber,this.imagePath});
}
