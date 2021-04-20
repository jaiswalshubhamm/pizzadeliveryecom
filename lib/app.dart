import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'providers/themeProvider.dart';
import 'config/palette.dart';
import 'providers/app.dart';
import 'providers/category.dart';
import 'providers/product.dart';
import 'providers/restaurant.dart';
import 'providers/auth.dart';
import 'screens/home/home.dart';
import 'router.dart' as router;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);

          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);

          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: AppProvider()),
              ChangeNotifierProvider.value(value: AuthProvider.initialize()),
              ChangeNotifierProvider.value(
                  value: CategoryProvider.initialize()),
              ChangeNotifierProvider.value(
                  value: RestaurantProvider.initialize()),
              ChangeNotifierProvider.value(value: ProductProvider.initialize()),
            ],
            child: MaterialApp(
              title: 'The Pizza Hub',
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              home: AnimatedSplashScreen(
                duration: 2500,
                splash: Image.asset("assets/main_bg.png"),
                splashIconSize: 140,
                nextScreen: Home(),
                splashTransition: SplashTransition.scaleTransition,
                backgroundColor: Palette.white,
              ),
              initialRoute: '/',
              onGenerateRoute: router.generateRoute,
            ),
          );
        },
      );
}
