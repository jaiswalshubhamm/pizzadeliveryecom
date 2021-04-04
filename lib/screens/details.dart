import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/palette.dart';
import '../helpers/screenNavigation.dart';
import '../models/product.dart';
import '../providers/app.dart';
import '../providers/user.dart';
import '../widgets/loading.dart';
import '../screens/cart.dart';

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
        iconTheme: IconThemeData(color: Palette.black),
        backgroundColor: Palette.white,
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
      backgroundColor: Palette.white,
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
                        color: Palette.grey,
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
                            ScaffoldMessenger.of(context).showSnackBar(
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
                            color: Palette.primary,
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
                                      color: Palette.white,
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
                              color: Palette.primary,
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
