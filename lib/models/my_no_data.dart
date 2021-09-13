import 'package:caleb_j_restaurant/models/my_botton.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/material.dart';

class MyNoData extends StatelessWidget {
  var icon;
  String? title, content, buttonTitle;

  MyNoData({Key? key, this.icon, this.title, this.content, this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionScreenWidth(48.0),
        vertical: getProportionteScreenHeight(42.0),
      ),
      child: Column(
        children: [
          Spacer(flex: 6),
          Expanded(
            child: icon ?? Container(),
            flex: 6,
          ),
          Spacer(flex: 1),
          Expanded(
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: getProportionteScreenHeight(28.0),
                ),
              ),
              flex: 2),
          Expanded(
            child: Text(
              content!,
              style: TextStyle(
                fontSize: getProportionteScreenHeight(18.0),
                color: Colors.black45,
              ),
              textAlign: TextAlign.center,
            ),
            flex: 10,
          ),
          MyBotton(
            title: buttonTitle!,
            myOnPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
