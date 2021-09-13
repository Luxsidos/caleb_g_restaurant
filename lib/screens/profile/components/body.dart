import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/models/my_botton.dart';
import 'package:caleb_j_restaurant/screens/profile/components/payment_method.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyAppBar(
          myLeading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: getProportionteScreenHeight(24.0),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          myTitle: Expanded(
            child: Text(
              "My profile",
              style: TextStyle(fontSize: getProportionteScreenHeight(18.0)),
              textAlign: TextAlign.center,
            ),
            flex: 11,
          ),
          myTrailing: Expanded(
            child: Container(),
            flex: 3,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionScreenWidth(48.0),
                right: getProportionScreenWidth(48.0),
                bottom: getProportionteScreenHeight(42.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Information",
                    style: TextStyle(
                      fontSize: getProportionteScreenHeight(18.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  flex: 1,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.0),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: getProportionteScreenHeight(8.0),
                    horizontal: getProportionScreenWidth(16.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: getProportionteScreenHeight(60.0),
                        width: getProportionScreenWidth(60.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: kPrimaryColor,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              CupertinoIcons.person_fill,
                              color: Colors.white70,
                              size: getProportionteScreenHeight(56.0),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(_authentication
                              .authUser.currentUser!.email!
                              .replaceAll("@gmail.com", "")),
                          subtitle: Text(
                              _authentication.authUser.currentUser!.email!),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1),
                Expanded(
                  child: Text(
                    "Payment Method",
                    style: TextStyle(
                      fontSize: getProportionteScreenHeight(18.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: PaymentMethod(),
                  flex: 10,
                ),
                MyBotton(
                  title: "Update Information",
                  myOnPressed: () {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
