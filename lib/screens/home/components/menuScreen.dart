import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItem {
  String title;
  IconData icon;
  MenuItem(this.icon, this.title);
}

class MenuScreen extends StatelessWidget {
  MenuScreen({Key? key}) : super(key: key);

  final List<MenuItem> options = [
    MenuItem(CupertinoIcons.person_alt_circle, 'Profile'),
    MenuItem(Icons.add_shopping_cart_rounded, 'orders'),
    MenuItem(Icons.local_offer_outlined, 'offer and promo'),
    MenuItem(CupertinoIcons.doc_text, 'Orders'),
    MenuItem(Icons.security, 'Security'),
  ];

  Authentication _authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionScreenWidth(8.0)),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: kPrimaryColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: options.map((e) {
                return ListTile(
                  onTap: () {},
                  leading: Icon(
                    e.icon,
                    color: Colors.white,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Divider(
                        color: Colors.white54,
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
            ListTile(
              onTap: () async {
                _authentication.userSignOut(context);
              },
              title: Row(
                children: [
                  Text(
                    "Sign-out",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: getProportionScreenWidth(8.0)),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
