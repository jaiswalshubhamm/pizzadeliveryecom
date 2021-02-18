import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Helpers/order.dart';
import 'package:pizzadeliveryecom/Helpers/user.dart';
import 'package:pizzadeliveryecom/Models/cartItem.dart';
import 'package:pizzadeliveryecom/Models/orders.dart';
import 'package:pizzadeliveryecom/Models/product.dart';
import 'package:pizzadeliveryecom/Models/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Unauthenticated, Authenticating, Authenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;

  // getters
  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  final formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanges);
  }

  Future<bool> signIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((result) {
        _firestore.collection('users').doc(result.user.uid).set({
          'name': name.text,
          'email': email.text,
          'uid': result.user.uid,
          'likedFood': [],
          'likedRestaurants': [],
        });
      });
      return true;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void clearController() {
    name.text = '';
    password.text = '';
    email.text = '';
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanges(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(firebaseUser.uid.toString());
    }
    notifyListeners();
  }

  Future<bool> addToCart({ProductModel product, int quantity}) async {
    print("The Product Is: ${product.toString()}");
    print("The Quantity Is: ${quantity.toString()}");

    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.image,
        "restaurantId": product.restaurantId,
        "totalRestaurantSale": product.price * quantity,
        "productId": product.id,
        "price": product.price,
        "quantity": quantity
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
      print("Cart Items Are: ${cart.toString()}");
      _userServices.addToCart(userId: _user.uid, cartItem: item);
      return true;
    } catch (e) {
      print("The Error is ${e.toString()}");
      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<bool> removeFromCart({CartItemModel cartItem}) async {
    print("The Product Is: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("The Error Is: ${e.toString()}");
      return false;
    }
  }
}
