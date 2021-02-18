import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/Config/Constant.dart';
import 'package:pizzadeliveryecom/Helpers/screenNavigation.dart';
import 'package:pizzadeliveryecom/Providers/user.dart';
import 'package:pizzadeliveryecom/src/Screens/login.dart';
import 'package:pizzadeliveryecom/Widgets/loading.dart';
import 'package:pizzadeliveryecom/src/Screens/home.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      body: authProvider.status == Status.Authenticating
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
                          "REGISTER",
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            controller: authProvider.name,
                            cursorColor: primary,
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: primary,
                              ),
                              hintText: 'Username',
                              border: InputBorder.none,
                            ),
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
                            controller: authProvider.email,
                            cursorColor: primary,
                            decoration: InputDecoration(
                              hintText: "Email",
                              icon: Icon(
                                Icons.mail,
                                color: primary,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: kPrimaryLightColor,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            controller: authProvider.password,
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
                                vertical: 20,
                                horizontal: 40,
                              ),
                              color: primary,
                              onPressed: () async {
                                if (!await authProvider.signUp()) {
                                  _key.currentState.showSnackBar(
                                    SnackBar(
                                      content: Text('Registration failed!'),
                                    ),
                                  );
                                  return;
                                }
                                authProvider.clearController();
                                changeScreenReplacement(
                                  context,
                                  Home(),
                                );
                              },
                              child: Container(
                                child: Text(
                                  'REGISTER',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            changeScreen(context, LoginScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Login here',
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
