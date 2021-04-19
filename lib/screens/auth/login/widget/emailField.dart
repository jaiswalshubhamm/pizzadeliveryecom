import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pizzadeliveryecom/config/palette.dart';

class EmailFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const EmailFieldWidget({
    Key key,
    @required this.controller,
  }) : super(key: key);

  @override
  _EmailFieldWidgetState createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<EmailFieldWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(onListen);
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: 'Email',
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.darkerGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Palette.red),
            ),
            prefixIcon: Icon(Icons.mail, color: Palette.primary),
            suffixIcon: widget.controller.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(Icons.close, color: Palette.black),
                    onPressed: () => widget.controller.clear(),
                  ),
          ),
          keyboardType: TextInputType.emailAddress,
          autofillHints: [AutofillHints.email],
          autofocus: true,
          validator: (email) => email != null && !EmailValidator.validate(email)
              ? 'Enter a valid email'
              : null,
        ),
      );
}
