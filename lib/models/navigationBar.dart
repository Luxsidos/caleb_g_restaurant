import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/screens/history/history_page.dart';
import 'package:caleb_j_restaurant/screens/orders/orders_page.dart';
import 'package:caleb_j_restaurant/screens/profile/profile_page.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  var lst = [
    Icons.home,
    CupertinoIcons.heart,
    CupertinoIcons.person,
    CupertinoIcons.time,
  ];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? allData;

  var lstPage = [
    Container(),
    ProfilePage(),
    HistoryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding:
          EdgeInsets.symmetric(vertical: getProportionteScreenHeight(22.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          lst.length,
          (index) {
            return IconButton(
              icon: index == 0
                  ? Icon(
                      lst[index],
                      color: kPrimaryColor,
                      size: getProportionteScreenHeight(36.0),
                    )
                  : Icon(
                      lst[index],
                      size: getProportionteScreenHeight(28.0),
                    ),
              onPressed: () async {
                if (index == 1) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Waiting...")));
                  QuerySnapshot<Map<String, dynamic>> data =
                      await _firestore.collection('carts').get();

                  allData = data.docs;
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPage(allDatas: allData!),
                    ),
                  );
                  
                } else if (index != 0) {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => lstPage[index - 1]),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
