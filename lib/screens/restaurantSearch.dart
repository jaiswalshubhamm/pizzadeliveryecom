// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../config/palette.dart';
// import '../helpers/screenNavigation.dart';
// import '../providers/app.dart';
// import '../providers/product.dart';
// import '../providers/restaurant.dart';
// import '../widgets/loading.dart';
// import '../widgets/restaurants.dart';
// import '../screens/cart.dart';
// import '../screens/restaurant.dart';

// class RestaurantSearchScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final restaurantProvider = Provider.of<RestaurantProvider>(context);
//     final productProvider = Provider.of<ProductProvider>(context);
//     final app = Provider.of<AppProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Palette.black),
//         backgroundColor: Palette.white,
//         leading: IconButton(
//           icon: Icon(Icons.close),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           "Restaurants",
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//         elevation: 0.0,
//         centerTitle: true,
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.shopping_cart),
//             onPressed: () {
//               changeScreen(context, CartScreen());
//             },
//           ),
//         ],
//       ),
//       body: app.isLoading
//           ? Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[Loading()],
//               ),
//             )
//           : restaurantProvider.searchedRestaurants.length < 1
//               ? Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Icon(
//                           Icons.search,
//                           color: Palette.grey,
//                           size: 30,
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           "No Restaurant Found",
//                           style: TextStyle(
//                             color: Palette.grey,
//                             fontWeight: FontWeight.w300,
//                             fontSize: 22,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )
//               : ListView.builder(
//                   itemCount: restaurantProvider.searchedRestaurants.length,
//                   itemBuilder: (context, index) {
//                     return GestureDetector(
//                       onTap: () async {
//                         app.changeLoading();
//                         await productProvider.loadProductsByRestaurant(
//                             restaurantId: restaurantProvider
//                                 .searchedRestaurants[index].id);
//                         app.changeLoading();
//                         changeScreen(
//                           context,
//                           RestaurantScreen(
//                             restaurantModel:
//                                 restaurantProvider.searchedRestaurants[index],
//                           ),
//                         );
//                       },
//                       child: RestaurantWidget(
//                         restaurant:
//                             restaurantProvider.searchedRestaurants[index],
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }
