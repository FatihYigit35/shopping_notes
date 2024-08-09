import 'package:shopping_notes/model/category.dart';

class ShoppingItem {
  const ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final Category category;
}
