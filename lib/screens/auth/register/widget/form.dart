import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/auth.dart';
import '../../../../config/palette.dart';
import '../../../../service/screenNavigation.dart';
import '../../../../widgets/customText.dart';
import 'name.dart';
import 'emailField.dart';
import 'password.dart';

class FormWidgetSignup extends StatefulWidget {
  @override
  _FormWidgetSignupState createState() => _FormWidgetSignupState();
}

class _FormWidgetSignupState extends State<FormWidgetSignup> {
  Map<String, String> _formData = {
    'name': '',
    'email': '',
    'password': '',
    'confirmPassword': ''
  };
  final formKey2 = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authData = Provider.of<AuthProvider>(context);
    return Form(
      key: formKey2,
      child: AutofillGroup(
        child: Column(
          children: [
            NameFieldWidget(controller: nameController),
            SizedBox(height: size.height * 0.02),
            EmailFieldWidget(controller: emailController),
            SizedBox(height: size.height * 0.02),
            PasswordFieldWidget(controller: passwordController),
            SizedBox(height: size.height * 0.02),
            PasswordFieldWidget(controller: confirmPasswordController),
            SizedBox(height: size.height * 0.02),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () async {
                  if (!formKey2.currentState.validate()) {
                    return;
                  }
                  _formData['name'] = nameController.text;
                  _formData['email'] = emailController.text;
                  _formData['password'] = passwordController.text;
                  _formData['confirmPassword'] = confirmPasswordController.text;
                  formKey2.currentState.save();
                  if (_formData['password'] != _formData['confirmPassword']) {
                    _showAlertDialog(
                      'Password and confirm password must be same...',
                    );
                    return;
                  }
                  authData.signUp(_formData['name'], _formData['email'],
                      _formData['password']);
                  if (authData.status == AuthResultStatus.successful) {
                    changeScreen(context, '/home');
                  } else {
                    final errorMsg =
                        AuthExceptionHandler.generateExceptionMessage(
                      authData.status,
                    );
                    _showAlertDialog(errorMsg);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Palette.primary,
                  ),
                  child: CustomText(text: "SIGN UP", weight: FontWeight.bold),
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
          title: CustomText(text: 'Signup Failed', color: Palette.primary),
          content: Text(errorMsg),
        );
      },
    );
  }
}
