import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/screens/home/home_page.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormFieldState> _formKey1 = GlobalKey<FormFieldState>(),
      _formKey2 = GlobalKey<FormFieldState>();

  Authentication _authUser = Authentication();

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  bool _showText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionteScreenHeight(42.0),
        horizontal: getProportionScreenWidth(52.0),
      ),
      child: Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          primaryColor: Colors.green,
          hintColor: Colors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              key: _formKey1,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                labelText: "Email address",
                hintText: "enter the email address...",
              ),
              validator: (e) {
                if (!_emailCheck(e)) {
                  return "Enter the email full";
                }
              },
            ),
            Spacer(flex: 1),
            TextFormField(
              key: _formKey2,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Colors.black54,
              controller: passwordController,
              obscureText: _showText,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "enter the password...",
                suffixIcon: IconButton(
                  icon: Icon(
                    _showText
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill,
                  ),
                  onPressed: () {
                    setState(() {
                      _showText = !_showText;
                    });
                  },
                ),
              ),
              validator: (e) {
                if (e!.length < 8) {
                  return "the password must be more than 8";
                }
              },
            ),
            Spacer(flex: 1),
            Text(
              "Forgot passcode?",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: getProportionteScreenHeight(18.0),
              ),
            ),
            Spacer(
              flex: 8,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: getProportionteScreenHeight(18.0),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                      onPressed: () {
                        if (_formKey1.currentState!.validate() &&
                            _formKey2.currentState!.validate()) {
                          _authUser.userLogin(emailController.text,
                              passwordController.text, context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  bool _emailCheck(email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
