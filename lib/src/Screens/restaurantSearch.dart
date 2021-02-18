import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Config/Constant.dart';
import 'package:pizzadeliveryecom/Helpers/screenNavigation.dart';
import 'package:pizzadeliveryecom/Models/restaurant.dart';
import 'package:pizzadeliveryecom/Providers/app.dart';
import 'package:pizzadeliveryecom/Providers/product.dart';
import 'package:pizzadeliveryecom/Providers/restaurant.dart';
import 'package:pizzadeliveryecom/Widgets/loading.dart';
import 'package:pizzadeliveryecom/Widgets/restaurants.dart';
import 'package:pizzadeliveryecom/src/Screens/cart.dart';
import 'package:pizzadeliveryecom/src/Screens/restaurant.dart';
import 'package:provider/provider.dart';

class RestaurantSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Restaurants",
          style: TextStyle(
            fontSize: 20,
          ),
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
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : restaurantProvider.searchedRestaurants.length < 1
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "No Restaurant Found",
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
                  itemCount: restaurantProvider.searchedRestaurants.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        app.changeLoading();
                        await productProvider.loadProductsByRestaurant(
                            restaurantId: restaurantProvider
                                .searchedRestaurants[index].id);
                        app.changeLoading();
                        changeScreen(
                            context,
                            RestaurantScreen(
                              restaurantModel:
                                  restaurantProvider.searchedRestaurants[index],
                            ));
                      },
                      child: RestaurantWidget(
                          restaurant:
                              restaurantProvider.searchedRestaurants[index]),
                    );
                  },
                ),
    );
  }
}
