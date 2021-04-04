import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/palette.dart';
import '../providers/app.dart';
import '../providers/user.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  // final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return user.userModel.cart.length < 1
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Palette.grey,
                    size: 30,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Products found",
                    style: TextStyle(
                      color: Palette.grey,
                      fontWeight: FontWeight.w300,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ],
          )
        : ListView.builder(
            itemCount: user.userModel.cart.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Palette.white,
                      boxShadow: [
                        BoxShadow(
                          color: Palette.primary.withOpacity(0.2),
                          offset: Offset(3, 2),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          child: Image.network(
                            user.userModel.cart[index].image,
                            height: 120,
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: user.userModel.cart[index].name +
                                          "\n",
                                      style: TextStyle(
                                        color: Palette.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "\$${user.userModel.cart[index].price / 100} \n\n",
                                      style: TextStyle(
                                        color: Palette.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "Quantity: ",
                                      style: TextStyle(
                                        color: Palette.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    TextSpan(
                                      text: user.userModel.cart[index].quantity
                                          .toString(),
                                      style: TextStyle(
                                        color: Palette.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Palette.primary,
                                ),
                                onPressed: () async {
                                  app.changeLoading();
                                  bool value = await user.removeFromCart(
                                      cartItem: user.userModel.cart[index]);
                                  if (value) {
                                    user.reloadUserModel();
                                    print("Item added to cart");
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Removed from Cart!"),
                                      ),
                                    );
                                    app.changeLoading();
                                    return;
                                  } else {
                                    print("Item was not Removed");
                                    app.changeLoading();
                                  }
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              );
            },
          );
  }
}
