import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/common_widgets/back_button.dart' as bb;
import 'package:flutter_myntra_clone/data_provider/product_data.dart';
import 'package:flutter_myntra_clone/data_provider/product_dto.dart';
import 'package:flutter_myntra_clone/screens/products/product.dart';

class ProductList extends StatelessWidget {
  static const routeName = '/products';

  @override
  Widget build(BuildContext context) {
    List<ProductDto> products = ProductData.getProductsListData();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 5),
              color: Theme.of(context).colorScheme.secondary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      bb.BackButton(), // Ensure this widget exists in back_button.dart
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Wrogn-Tshirts',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${products.length} items', // Dynamic item count
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.search, color: Colors.black),
                        onPressed: () {}, // Fix missing onPressed
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border, color: Colors.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_bag_outlined,
                            color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.all(5),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return Product(products[
                        index]); // Passes product as a positional argument
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
