import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/palette.dart';
import 'providers/user.dart';
import 'widgets/loading.dart';
import 'screens/login.dart';
import 'screens/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Pizza Hub',
      theme: ThemeData(
        primaryColor: Palette.primary,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ScreenController(),
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Loading();
      // return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
