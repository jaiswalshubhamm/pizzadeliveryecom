import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/palette.dart';
import '../helpers/screenNavigation.dart';
import '../providers/product.dart';
import '../widgets/product.dart';
import '../screens/cart.dart';
import '../screens/details.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Palette.black),
        backgroundColor: Palette.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Products",
          style: TextStyle(fontSize: 20),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
      ),
      body: productProvider.productsSearched.length < 1
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.search,
                      color: Palette.grey,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Products found",
                      style: TextStyle(
                        color: Palette.grey,
                        fontWeight: FontWeight.w300,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ],
            )
          : ListView.builder(
              itemCount: productProvider.productsSearched.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    changeScreen(
                      context,
                      Details(product: productProvider.productsSearched[index]),
                    );
                  },
                  child: ProductWidget(
                    product: productProvider.productsSearched[index],
                  ),
                );
              },
            ),
    );
  }
}
