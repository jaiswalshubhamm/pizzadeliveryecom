import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = 'id';
  static const NAME = 'name';
  static const RATING = 'rating';
  static const IMAGE = 'image';
  static const PRICE = 'price';
  static const RESTAURANT_ID = 'restaurantId';
  static const RESTAURANT = 'restaurant';
  static const CATEGORY = 'category';
  static const FEATURED = 'featured';
  static const RATES = 'rated';
  static const DESCRIPTION = 'description';
  static const USERLIKES = 'userLikes';

  String _id;
  String _name;
  String _restaurantId;
  String _restaurant;
  String _category;
  String _image;
  String _description;
  double _rating;
  int _price;
  int _rates;
  bool _featured;

  String get id => _id;
  String get name => _name;
  String get restaurant => _restaurant;
  String get restaurantId => _restaurantId;
  String get category => _category;
  String get description => _description;
  String get image => _image;
  double get rating => _rating;
  int get price => _price;
  bool get featured => _featured;
  int get rates => _rates;
  bool liked = false; // public variable

  ProductModel.fromSnapShot(DocumentSnapshot snapshot) {
    _id = snapshot.data()[ID];
    _name = snapshot.data()[NAME];
    _image = snapshot.data()[IMAGE];
    _restaurant = snapshot.data()[RESTAURANT];
    _restaurantId = snapshot.data()[RESTAURANT_ID].toString();
    _description = snapshot.data()[DESCRIPTION];
    _featured = snapshot.data()[FEATURED];
    _price = snapshot.data()[PRICE].floor();
    _category = snapshot.data()[CATEGORY];
    _rating = snapshot.data()[RATING];
    _rates = snapshot.data()[RATES];
  }
}
