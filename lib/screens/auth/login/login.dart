import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/palette.dart';
import '../../../service/screenNavigation.dart';
import '../../../providers/auth.dart';
import '../../../widgets/customText.dart';
import '../../home/home.dart';
import '../background.dart';
import 'widget/form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authData = Provider.of<AuthProvider>(context);
    return (authData.isLoggedIn)
        ? Home()
        : Scaffold(
            body: SingleChildScrollView(
              child: Background(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: "Welcome Back",
                        weight: FontWeight.w700,
                        color: Palette.primary,
                        size: 24,
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Image.asset(
                      'assets/main_bg.png',
                      height: size.height * 0.35,
                    ),
                    SizedBox(height: size.height * 0.02),
                    FormWidgetLogin(),
                    SizedBox(height: size.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        changeScreen(context, '/register');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don't have an account? ",
                            weight: FontWeight.w600,
                            size: 12,
                          ),
                          CustomText(
                            text: "Sign up",
                            color: Palette.primary,
                            weight: FontWeight.w600,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
