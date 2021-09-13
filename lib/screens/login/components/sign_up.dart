import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/screens/home/home_page.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormFieldState> _formKey1 = GlobalKey<FormFieldState>(),
      _formKey2 = GlobalKey<FormFieldState>();

  Authentication _authUser = Authentication();

  TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();

  bool _showText = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.green,
        hintColor: Colors.black,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionteScreenHeight(42.0),
            horizontal: getProportionScreenWidth(52.0),
          ),
          child: Column(
            children: [
              TextFormField(
                key: _formKey1,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.black54,
                decoration: InputDecoration(
                  labelText: "Email address",
                  hintText: "enter the email address...",
                ),
                validator: (e) {
                  if (!_emailCheck(e)) {
                    return "enter the email full";
                  }
                },
              ),
              SizedBox(height: getProportionteScreenHeight(24.0)),
              TextFormField(
                cursorColor: Colors.black54,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "enter the Phone Number...",
                ),
              ),
              SizedBox(height: getProportionteScreenHeight(32.0)),
              TextFormField(
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: _showText,
                key: _formKey2,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                cursorColor: Colors.black54,
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
              SizedBox(height: getProportionteScreenHeight(56.0)),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(
                        "Register",
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
                          _authUser.userSignUp(emailController.text,
                              passwordController.text, context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
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
