import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/config/palette.dart';
import 'package:pizzadeliveryecom/widgets/customText.dart';
import 'package:provider/provider.dart';
import 'emailField.dart';
import 'password.dart';
// import '../../../providers/authProvider.dart';

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
    return Form(
      key: formKey,
      child: SingleChildScrollView(
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
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(content: Text('Authenticating User..')));
                      // await Provider.of<AuthProvider>(
                      //   context,
                      //   listen: false,
                      // ).login(
                      //   _formData['email'],
                      //   _formData['password'],
                      // );
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
      ),
    );
  }
}
