import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pizzadeliveryecom/Models/cartItem.dart';
import 'package:pizzadeliveryecom/Models/user.dart';

class UserServices {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void createUser(Map<String, dynamic> values) {
    String id = values["id"];
    users.doc(id).set(values);
  }

  void updateUserData(Map<String, dynamic> values) {
    String id = values["id"];
    users.doc(id).update(values);
  }

  void addToCart({String userId, CartItemModel cartItem}) {
    print("The User ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    users.doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart({String userId, CartItemModel cartItem}) {
    print("The User ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    users.doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

  Future<UserModel> getUserById(String userId) =>
      users.doc(userId).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });
}
