import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Config/Constant.dart';
import 'package:pizzadeliveryecom/Models/orders.dart';
import 'package:pizzadeliveryecom/Providers/user.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        title: Text("orders"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: ListView.builder(
        itemCount: user.orders.length,
        itemBuilder: (_, index) {
          OrderModel order = user.orders[index];
          return ListTile(
            leading: Text(
              "\$${order.amount / 100}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            title: Text(order.description),
            subtitle: Text(DateTime.fromMicrosecondsSinceEpoch(order.createdAt)
                .toString()),
            trailing: Text(
              order.status,
              style: TextStyle(
                color: primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
