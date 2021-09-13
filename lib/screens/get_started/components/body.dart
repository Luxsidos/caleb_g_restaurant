import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/screens/login/login_page.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: getProportionteScreenHeight(36.0),
            right: getProportionteScreenHeight(36.0),
            top: getProportionScreenWidth(50.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(getProportionteScreenHeight(12.0)),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Image.asset(
                  "assets/images/1.png",
                  height: getProportionteScreenHeight(48.0),
                ),
              ),
              SizedBox(
                height: getProportionteScreenHeight(34.0),
              ),
              Text(
                "CALEB G Restaurant",
                style: TextStyle(
                    fontSize: getProportionteScreenHeight(56.0),
                    color: kBackgroundColor),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundPerson.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          flex: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionteScreenHeight(36.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: getProportionteScreenHeight(24.0),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                          fontSize: getProportionteScreenHeight(22.0)),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: kBackgroundColor,
                    primary: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
