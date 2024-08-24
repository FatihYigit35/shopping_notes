import 'package:flutter/material.dart';
import 'package:shopping_notes/data/i18n.dart';
import 'package:shopping_notes/model/categories.dart';
import 'package:shopping_notes/model/category.dart';

final categories = {
  Categories.vegetables: Category(
    appLocalizations.vegetables,
    color: Colors.green,
  ),
  Categories.fruit: Category(
    appLocalizations.fruit,
    color: Colors.lime,
  ),
  Categories.meat: Category(
    appLocalizations.meat,
    color: Colors.red,
  ),
  Categories.dairy: Category(
    appLocalizations.dairy,
    color: Colors.cyan,
  ),
  Categories.carbs: Category(
    appLocalizations.carbs,
    color: Colors.indigo,
  ),
  Categories.sweets: Category(
    appLocalizations.sweets,
    color: Colors.orange,
  ),
  Categories.spices: Category(
    appLocalizations.spices,
    color: Colors.yellow,
  ),
  Categories.convenience: Category(
    appLocalizations.convenience,
    color: Colors.deepPurple,
  ),
  Categories.hygiene: Category(
    appLocalizations.hygiene,
    color: Colors.purple,
  ),
  Categories.other: Category(
    appLocalizations.other,
    color: Colors.grey,
  ),
};
