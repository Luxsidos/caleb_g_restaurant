import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
  Function myOnPressed;
  String title;
  MyBotton({required this.title, required this.myOnPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionteScreenHeight(20.0)),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: getProportionteScreenHeight(18.0),
                    color: Colors.white),
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: kPrimaryColor,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
            ),
            onPressed: () {
              myOnPressed();
            },
          ),
        ),
      ],
    );
  }
}
