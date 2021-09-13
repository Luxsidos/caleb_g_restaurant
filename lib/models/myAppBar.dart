import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  Widget? myLeading;
  Widget? myTitle;
  Widget? myTrailing;
  MyAppBar({Key? key, this.myLeading, this.myTitle, this.myTrailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionScreenWidth(32.0),
        vertical: getProportionteScreenHeight(32.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          myLeading ?? Container(),
          myTitle ?? Container(),
          myTrailing ?? Container(),
        ],
      ),
    );
  }
}
