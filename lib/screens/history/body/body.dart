import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/models/my_botton.dart';
import 'package:caleb_j_restaurant/models/my_no_data.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

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
              "History",
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
          child: MyNoData(
            icon: Image.asset("assets/icons/Vector.png"),
            title: "No history yet",
            content: "Hit the orange button down below to Create an order",
            buttonTitle: "Start ordering",
          ),
        ),
      ],
    );
  }
}
