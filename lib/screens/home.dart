import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/palette.dart';
import '../service/screenNavigation.dart';
import '../providers/app.dart';
import '../providers/category.dart';
import '../providers/product.dart';
import '../providers/restaurant.dart';
import '../widgets/categories.dart';
import '../widgets/featuredProduct.dart';
import '../widgets/loading.dart';
import '../widgets/restaurants.dart';
import '../widgets/drawer.dart';
import '../screens/cart.dart';
import '../screens/category.dart';
import '../screens/productSearch.dart';
import '../screens/restaurant.dart';
import '../screens/restaurantSearch.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    restaurantProvider.loadSingleRestaurant();

    return Scaffold(
      drawer: Drawer(child: MenuDrawer()),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Palette.white),
        elevation: 0.5,
        backgroundColor: Palette.primary,
        title: Text('The Pizza Hub'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // changeScreen(context, CartScreen());
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {
              // changeScreen(context, CartScreen());
            },
          ),
        ],
      ),
      backgroundColor: Palette.white,
      body: app.isLoading
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Loading()],
              ),
            )
          : SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.primary,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 8,
                        right: 8,
                        bottom: 10,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Palette.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: Palette.primary,
                          ),
                          title: TextField(
                            textInputAction: TextInputAction.search,
                            // onSubmitted: (pattern) async {
                            //   app.changeLoading();
                            //   if (app.search == SearchBy.PRODUCTS) {
                            //     await productProvider.search(
                            //         productName: pattern);
                            //     changeScreen(context, ProductSearchScreen());
                            //   } else {
                            //     await restaurantProvider.search(name: pattern);
                            //     changeScreen(context, RestaurantSearchScreen());
                            //   }
                            //   app.changeLoading();
                            // },
                            decoration: InputDecoration(
                              hintText: 'Find food and restaurant',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        'Search by:',
                        style: TextStyle(
                          color: Palette.grey,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      DropdownButton<String>(
                        value: app.filterBy,
                        style: TextStyle(
                          color: Palette.primary,
                          fontWeight: FontWeight.w300,
                        ),
                        icon: Icon(
                          Icons.filter_list,
                          color: Palette.primary,
                        ),
                        elevation: 0,
                        onChanged: (value) {
                          if (value == "Products") {
                            app.changeSearchBy(newSearchBy: SearchBy.PRODUCTS);
                          } else {
                            app.changeSearchBy(
                                newSearchBy: SearchBy.RESTAURANTS);
                          }
                        },
                        items: <String>['Products', 'Restaurants']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryProvider.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // onTap: () async {
                          //   await productProvider.loadProductsByCategory(
                          //       categoryName:
                          //           categoryProvider.categories[index].name);
                          //   changeScreen(
                          //     context,
                          //     CategoryScreen(
                          //       categoryModel:
                          //           categoryProvider.categories[index],
                          //     ),
                          //   );
                          // },
                          child: CategoryWidget(
                            category: categoryProvider.categories[index],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Featureed',
                          style: TextStyle(
                            color: Palette.grey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Featured(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Popular Restaurants',
                          style: TextStyle(
                            color: Palette.grey,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: restaurantProvider.restaurants
                        .map(
                          (item) => GestureDetector(
                            // onTap: () async {
                            //   app.changeLoading();
                            //   await productProvider.loadProductsByRestaurant(
                            //       restaurantId: item.id);
                            //   app.changeLoading();
                            //   changeScreen(
                            //     context,
                            //     RestaurantScreen(
                            //       restaurantModel: item,
                            //     ),
                            //   );
                            // },
                            child: RestaurantWidget(
                              restaurant: item,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
