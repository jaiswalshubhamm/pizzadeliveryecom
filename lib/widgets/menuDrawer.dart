import 'package:flutter/material.dart';
import '../config/palette.dart';
import '../helpers/screenNavigation.dart';
import '../providers/user.dart';
import '../screens/cart.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: Palette.primary,
          ),
          accountName: Text(
            user.userModel.name ?? 'username loading...',
            style: TextStyle(
              color: Palette.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          accountEmail: Text(
            user.userModel.email ?? 'email loading...',
            style: TextStyle(
              color: Palette.white,
            ),
          ),
          currentAccountPicture: GestureDetector(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
        ),
        ListTile(
          onTap: () {
            changeScreen(context, Home());
          },
          leading: Icon(Icons.home),
          title: Text('Home'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.person),
          title: Text('My Account'),
        ),
        ListTile(
          onTap: () {
            // changeScreen(context, OrdersScreen());
          },
          leading: Icon(Icons.bookmark_border),
          title: Text('My Orders'),
        ),
        ListTile(
          onTap: () {
            changeScreen(context, CartScreen());
          },
          leading: Icon(Icons.shopping_cart),
          title: Text('Cart'),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.favorite),
          title: Text('Favorite'),
        ),
        Divider(),
        ListTile(
          onTap: () {},
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        ListTile(
          onTap: () {
            user.signOut();
            changeScreenReplacement(context, LoginScreen());
          },
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
        ),
      ],
    );
  }
}
