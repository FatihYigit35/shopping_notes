import 'package:shopping_notes/model/category.dart';

class ShoppingItem {
  ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  String id;
  String name;
  num quantity;
  Category category;
}
