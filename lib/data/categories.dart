import 'package:flutter/material.dart';
import 'package:shopping_notes/model/categories.dart';
import 'package:shopping_notes/model/category.dart';

const categories = {
  Categories.vegetables: Category(
    'Vegetables',
    color: Color.fromARGB(255, 0, 255, 128),
  ),
  Categories.fruit: Category(
    'Fruit',
    color: Color.fromARGB(255, 145, 255, 0),
  ),
  Categories.meat: Category(
    'Meat',
    color: Color.fromARGB(255, 255, 102, 0),
  ),
  Categories.dairy: Category(
    'Dairy',
    color: Color.fromARGB(255, 0, 208, 255),
  ),
  Categories.carbs: Category(
    'Carbs',
    color: Color.fromARGB(255, 0, 60, 255),
  ),
  Categories.sweets: Category(
    'Sweets',
    color: Color.fromARGB(255, 255, 149, 0),
  ),
  Categories.spices: Category(
    'Spices',
    color: Color.fromARGB(255, 255, 187, 0),
  ),
  Categories.convenience: Category(
    'Convenience',
    color: Color.fromARGB(255, 191, 0, 255),
  ),
  Categories.hygiene: Category(
    'Hygiene',
    color: Color.fromARGB(255, 149, 0, 255),
  ),
  Categories.other: Category(
    'Other',
    color: Color.fromARGB(255, 0, 225, 255),
  ),
};
