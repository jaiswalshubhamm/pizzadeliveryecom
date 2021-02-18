import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Config/Constant.dart';
import 'package:pizzadeliveryecom/Helpers/screenNavigation.dart';
import 'package:pizzadeliveryecom/Providers/product.dart';
import 'package:pizzadeliveryecom/Widgets/product.dart';
import 'package:pizzadeliveryecom/src/Screens/cart.dart';
import 'package:pizzadeliveryecom/src/Screens/details.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
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
                      color: grey,
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
                        color: grey,
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
