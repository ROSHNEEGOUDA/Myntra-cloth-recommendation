import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/screens/products/product_list.dart';

class Category extends StatefulWidget {
  final String categoryName;
  final String categoryDescription;
  final List<String> subCategories;
  final Color backgroundColor;

  const Category({
    Key? key,
    required this.categoryName,
    required this.categoryDescription,
    required this.subCategories,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card( // Used Card for better UI structure
      margin: const EdgeInsets.all(8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.categoryName,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.categoryDescription,
                          style: const TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: widget.subCategories.map((subcategory) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProductList.routeName);
                    },
                    title: Text(
                      subcategory,
                      style: const TextStyle(fontSize: 18),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
