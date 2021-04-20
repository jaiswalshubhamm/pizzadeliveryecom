import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/service/screenNavigation.dart';
import 'package:provider/provider.dart';
import '../../../../config/palette.dart';
import '../../../../providers/auth.dart';
import '../../../../widgets/customText.dart';
import 'emailField.dart';
import 'password.dart';

class FormWidgetLogin extends StatefulWidget {
  @override
  _FormWidgetLoginState createState() => _FormWidgetLoginState();
}

class _FormWidgetLoginState extends State<FormWidgetLogin> {
  Map<String, String> _formData = {
    'email': '',
    'password': '',
  };
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authData = Provider.of<AuthProvider>(context);
    return Form(
      key: formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            EmailFieldWidget(controller: emailController),
            SizedBox(height: size.height * 0.03),
            PasswordFieldWidget(controller: passwordController),
            SizedBox(height: size.height * 0.03),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () async {
                  _formData['email'] = emailController.text;
                  _formData['password'] = passwordController.text;
                  if (!formKey.currentState.validate()) {
                    return;
                  }
                  formKey.currentState.save();
                  if (formKey.currentState.validate()) {
                    await authData.signIn(
                        _formData['email'], _formData['password']);
                  }
                  print(authData.status);
                  if (authData.status == AuthResultStatus.successful) {
                    changeScreen(context, '/home');
                  } else {
                    final errorMsg =
                        await AuthExceptionHandler.generateExceptionMessage(
                      authData.status,
                    );
                    await _showAlertDialog(errorMsg);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Palette.primary,
                  ),
                  child: CustomText(text: "LOGIN", weight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(text: 'Login Failed', color: Palette.primary),
          content: Text(errorMsg),
        );
      },
    );
  }
}
