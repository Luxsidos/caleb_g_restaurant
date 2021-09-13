import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/screens/login/components/login.dart';
import 'package:caleb_j_restaurant/screens/login/components/sign_up.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TabController? _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32.0),
              ),
              boxShadow: [
                BoxShadow(
                  //offset: Offset(0.0,0.0),
                  blurRadius: 8.0,
                  spreadRadius: 1.0,
                  color: Colors.grey.shade200.withOpacity(0.2),
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/1.png",
                      width: getProportionScreenWidth(114.0),
                    ),
                  ),
                ),
                TabBar(
                  indicatorColor: kPrimaryColor,
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: getProportionScreenWidth(36.0),
                  ),
                  labelColor: kTextColor,
                  tabs: [
                    Tab(
                      text: "Login",
                    ),
                    Tab(text: "Sign-up"),
                  ],
                  controller: _tabController,
                ),
              ],
            ),
          ),
          flex: 4,
        ),
        Expanded(
          child: Container(
            color: kBackgroundColor,
            child: TabBarView(
              controller: _tabController,
              children: [
                Login(),
                SignUp()
              ],
            ),
          ),
          flex: 6,
        ),
      ],
    );
  }
}
