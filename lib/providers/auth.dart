import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../service/order.dart';
import '../service/user.dart';
import '../models/cartItem.dart';
import '../models/orders.dart';
import '../models/product.dart';
import '../models/user.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  bool _isLoggedIn = false;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserServices _userServices = UserServices();
  OrderServices _orderServices = OrderServices();
  UserModel _userModel;
  AuthResultStatus status;

  // getters
  UserModel get userModel => _userModel;
  bool get isLoggedIn => _isLoggedIn;
  User get user => _user;

  // public variables
  List<OrderModel> orders = [];

  AuthProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onStateChanges);
  }

  Future<bool> signIn() async {
    try {
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
          // email: email.text.trim(),
          // password: password.text.trim(),
          );
      return true;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      )
          .then(
        (result) {
          _firestore.collection('users').doc(result.user.uid).set(
            {
              'name': name,
              'email': email,
              'uid': result.user.uid,
              'likedFood': [],
              'likedRestaurants': [],
            },
          );
        },
      );
      return true;
    } catch (e) {
      print('Exception @createAccount: $e');
      status = AuthExceptionHandler.handleException(e);
      print(status);
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }

  Future<void> _onStateChanges(User firebaseUser) async {
    if (firebaseUser == null) {
    } else {
      _user = firebaseUser;
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

class AuthExceptionHandler {
  static handleException(e) {
    print(e.code);
    var status;
    switch (e.code) {
      case "email-already-in-use":
        status = AuthResultStatus.invalidEmail;
        break;
      case "ERROR_WRONG_PASSWORD":
        status = AuthResultStatus.wrongPassword;
        break;
      case "weak-password":
        status = AuthResultStatus.weakPassword;
        break;
      case "ERROR_USER_NOT_FOUND":
        status = AuthResultStatus.userNotFound;
        break;
      case "ERROR_USER_DISABLED":
        status = AuthResultStatus.userDisabled;
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatus.tooManyRequests;
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatus.operationNotAllowed;
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatus.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatus.undefined;
    }
    return status;
  }

  static generateExceptionMessage(exceptionStatus) {
    String errorMessage;
    switch (exceptionStatus) {
      case AuthResultStatus.invalidEmail:
        errorMessage =
            "The email address is already in use by another account.";
        break;
      case AuthResultStatus.wrongPassword:
        errorMessage = "Your password is wrong.";
        break;
      case AuthResultStatus.weakPassword:
        errorMessage = "Password should be at least 6 characters.";
        break;
      case AuthResultStatus.userNotFound:
        errorMessage = "User with this email doesn't exist.";
        break;
      case AuthResultStatus.userDisabled:
        errorMessage = "User with this email has been disabled.";
        break;
      case AuthResultStatus.tooManyRequests:
        errorMessage = "Too many requests. Try again later.";
        break;
      case AuthResultStatus.operationNotAllowed:
        errorMessage = "Signing in with Email and Password is not enabled.";
        break;
      case AuthResultStatus.emailAlreadyExists:
        errorMessage =
            "The email has already been registered. Please login or reset your password.";
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
    return errorMessage;
  }
}

enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  weakPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}
