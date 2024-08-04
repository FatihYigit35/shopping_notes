import 'package:shopping_notes/data/categories.dart';
import 'package:shopping_notes/model/shopping_item.dart';

const groceryItems = [
  ShoppingItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[Categories.dairy]!),
  ShoppingItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  ShoppingItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
];
