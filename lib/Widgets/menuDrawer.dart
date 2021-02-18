import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Config/Constant.dart';
import 'package:pizzadeliveryecom/Helpers/screenNavigation.dart';
import 'package:pizzadeliveryecom/Providers/user.dart';
import 'package:pizzadeliveryecom/src/Screens/cart.dart';
import 'package:pizzadeliveryecom/src/Screens/home.dart';
import 'package:pizzadeliveryecom/src/Screens/login.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(
            color: primary,
          ),
          accountName: Text(
            user.userModel.name ?? 'username loading...',
            style: TextStyle(
              color: white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          accountEmail: Text(
            user.userModel.email ?? 'email loading...',
            style: TextStyle(
              color: white,
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
