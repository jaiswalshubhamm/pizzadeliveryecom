import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizzadeliveryecom/Models/cartItem.dart';

class UserModel {
  static const UID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";

  String _name;
  String _email;
  String _uid;
  String _stripeId;
  int _priceSum = 0;
  int _quantitySum = 0;

//  getters
  String get name => _name;
  String get email => _email;
  String get uid => _uid;
  String get stripeId => _stripeId;

//  public variable
  List<CartItemModel> cart;
  int totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    _name = snapshot.data()[NAME];
    _email = snapshot.data()[EMAIL];
    _uid = snapshot.data()[UID];
    _stripeId = snapshot.data()[STRIPE_ID];
    cart = _convertCartItems(snapshot.data()[CART]) ?? [];
    totalCartPrice = snapshot.data()[CART] == null
        ? 0
        : getTotalPrice(cart: snapshot.data()[CART]);
  }

  int getTotalPrice({List cart}) {
    if (cart == null) {
      return 0;
    }
    for (Map cartItem in cart) {
      _priceSum += cartItem["price"] * cartItem["quantity"];
    }

    int total = _priceSum;
    return total;
  }

  List<CartItemModel> _convertCartItems(List cart) {
    List<CartItemModel> convertedCart = [];
    for (Map cartItem in cart) {
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }
}