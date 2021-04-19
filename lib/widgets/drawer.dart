import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/palette.dart';
import '../providers/auth.dart';
import '../service/screenNavigation.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context);
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: Palette.primary),
          accountName: Text(
            // user.userModel.name ??
            'username loading...',
            style: TextStyle(
              color: Palette.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          accountEmail: Text(
            // user.userModel.email ??
            'email loading...',
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
            changeScreen(context, '/home');
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
            changeScreen(context, '/cart');
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
            // user.signOut();
            changeScreen(context, '/login');
          },
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
        ),
      ],
    );
  }
}
