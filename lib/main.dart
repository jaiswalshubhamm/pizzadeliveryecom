import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pizzadeliveryecom/Providers/app.dart';
import 'package:pizzadeliveryecom/Providers/product.dart';
import 'package:provider/provider.dart';
import 'Providers/user.dart';
import 'Providers/category.dart';
import 'Providers/restaurant.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: App(),
    ),
  );
}
