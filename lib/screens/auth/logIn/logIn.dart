import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/palette.dart';
import '../../../helpers/screenNavigation.dart';
// import '../../../providers/user.dart';
import '../../../widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body:
          // userProvider.status == Status.Authenticating
          //     ? Loading()
          //     :
          Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                'assets/main_top.png',
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                'assets/login_bottom.png',
                width: size.width * 0.4,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Image.asset(
                    'assets/main_bg.png',
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Palette.kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      // controller: userProvider.email,
                      cursorColor: Palette.primary,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Palette.primary,
                        ),
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Palette.kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      // controller: userProvider.password,
                      obscureText: true,
                      cursorColor: Palette.primary,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: Palette.primary,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: Palette.primary,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: TextButton(
                        onPressed: () async {
                          // if (!await userProvider.signIn()) {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //       SnackBar(content: Text('Login failed!')));
                          //   return;
                          // }
                          // userProvider.clearController();
                          // changeScreenReplacement(context, '/home');
                        },
                        child: Text(
                          'LOGIN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      changeScreen(context, '/register');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Register here',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
