import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Config/Constant.dart';
import 'package:pizzadeliveryecom/Helpers/screenNavigation.dart';
import 'package:pizzadeliveryecom/Models/product.dart';
import 'package:pizzadeliveryecom/Providers/app.dart';
import 'package:pizzadeliveryecom/Providers/user.dart';
import 'package:pizzadeliveryecom/Widgets/loading.dart';
import 'package:pizzadeliveryecom/src/Screens/cart.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({@required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      key: _key,
      appBar: AppBar(
        iconTheme: IconThemeData(color: black),
        backgroundColor: white,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              changeScreen(context, CartScreen());
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: app.isLoading
            ? Loading()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(widget.product.image),
                  ),
                  SizedBox(height: 15),
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${widget.product.price / 100}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.product.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: grey,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.remove,
                            size: 36,
                          ),
                          onPressed: () {
                            if (quantity != 1) {
                              setState(() {
                                quantity -= 1;
                              });
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          app.changeLoading();
                          bool value = await user.addToCart(
                              product: widget.product, quantity: quantity);
                          if (value) {
                            _key.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Added to cart!"),
                              ),
                            );
                            user.reloadUserModel();
                            app.changeLoading();
                            return;
                          } else {
                            print("Item Not Added to cart");
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: app.isLoading
                              ? Loading()
                              : Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 12, 28, 12),
                                  child: Text(
                                    "Add $quantity To Cart",
                                    style: TextStyle(
                                      color: white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 36,
                              color: primary,
                            ),
                            onPressed: () {
                              setState(() {
                                quantity += 1;
                              });
                            },
                          )),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}
