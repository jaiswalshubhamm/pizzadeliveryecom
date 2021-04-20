import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/screens/auth/register/widget/form.dart';
import 'package:pizzadeliveryecom/widgets/customText.dart';
import 'package:provider/provider.dart';
import '../../../config/palette.dart';
import '../../../service/screenNavigation.dart';
import '../../../providers/auth.dart';
import '../../home/home.dart';
import '../background.dart';

class RegisterScreen extends StatelessWidget {
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
                        text: "Create a new account",
                        weight: FontWeight.w700,
                        size: 24,
                        color: Palette.primary,
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Image.asset(
                      'assets/main_bg.png',
                      height: size.height * 0.30,
                    ),
                    SizedBox(height: size.height * 0.02),
                    FormWidgetSignup(),
                    SizedBox(height: size.height * 0.02),
                    GestureDetector(
                      onTap: () {
                        changeScreen(context, '/login');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Already have an account? ',
                            weight: FontWeight.w600,
                            size: 12,
                          ),
                          CustomText(
                            text: 'Login here',
                            weight: FontWeight.w600,
                            color: Palette.primary,
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
