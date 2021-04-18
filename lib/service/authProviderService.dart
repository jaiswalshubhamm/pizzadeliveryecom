// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthProviderService {
//   final GoogleSignIn gSignIn = GoogleSignIn();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   AuthProviderService._();
//   bool isLogedIn = false;

//   static AuthProviderService instance = AuthProviderService._();

//   Future<void> signIn() async {
//     GoogleSignInAccount signInAccount = await GoogleSignIn().signIn();
//     GoogleSignInAuthentication authentication = await signInAccount.authentication;
//     AuthCredential authCredential = GoogleAuthProvider.credential(
//       idToken: authentication.idToken,
//       accessToken: authentication.accessToken,
//     );
//     await _auth.signInWithCredential(authCredential);
//   }

//   Future<void> signOut() async {
//     if( user != null) {
//       await _auth.signOut();
//     }
//     // await GoogleSignIn().disconnect();
//     await GoogleSignIn().signOut();
//   }

//   User get user => _auth.currentUser;
// }
