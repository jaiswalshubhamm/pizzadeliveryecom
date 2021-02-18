import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pizzadeliveryecom/Config/Constant.dart';
import 'package:pizzadeliveryecom/Helpers/screenNavigation.dart';
import 'package:pizzadeliveryecom/Providers/user.dart';
import 'package:pizzadeliveryecom/Widgets/loading.dart';
import 'package:pizzadeliveryecom/src/Screens/registration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: userProvider.status == Status.Authenticating
          ? Loading()
          : Container(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            controller: userProvider.email,
                            cursorColor: primary,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: primary,
                              ),
                              hintText: 'Email',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            controller: userProvider.password,
                            obscureText: true,
                            cursorColor: primary,
                            decoration: InputDecoration(
                              hintText: "Password",
                              icon: Icon(
                                Icons.lock,
                                color: primary,
                              ),
                              suffixIcon: Icon(
                                Icons.visibility,
                                color: primary,
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
                            child: FlatButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 40),
                              color: primary,
                              onPressed: () async {
                                if (!await userProvider.signIn()) {
                                  _key.currentState.showSnackBar(
                                      SnackBar(content: Text('Login failed!')));
                                  return;
                                }
                                userProvider.clearController();
                                changeScreenReplacement(context, Home());
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
                            changeScreen(context, RegistrationScreen());
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
