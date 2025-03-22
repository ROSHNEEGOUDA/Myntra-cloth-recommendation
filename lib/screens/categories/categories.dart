import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/screens/categories/category.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = '/categories';

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Men's Fashion",
      "description": "Explore trendy styles",
      "subcategories": ["T-Shirts", "Jeans", "Shoes"],
      "color": Colors.blue.shade100,
    },
    {
      "name": "Women's Fashion",
      "description": "Latest styles for women",
      "subcategories": ["Dresses", "Handbags", "Jewelry"],
      "color": Colors.pink.shade100,
    },
    {
      "name": "Electronics",
      "description": "Latest gadgets and accessories",
      "subcategories": ["Mobiles", "Laptops", "Headphones"],
      "color": Colors.green.shade100,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (ctx, index) {
          final category = categories[index];
          return Category(
            categoryName: category["name"],
            categoryDescription: category["description"],
            subCategories: List<String>.from(category["subcategories"]),
            backgroundColor: category["color"],
          );
        },
      ),
    );
  }
}
