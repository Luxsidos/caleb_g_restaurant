import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/models/my_botton.dart';
import 'package:caleb_j_restaurant/screens/orders/orders_page.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  String? collectionFood;
  Body({Key? key, this.collectionFood}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Authentication _authentication = Authentication();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> collectionNames = ["foods", 'drinks', 'snacks', 'sauces'];

  List<QueryDocumentSnapshot<Map<String, dynamic>>>? allDatas;

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
              "Cart",
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
        Expanded(child: Image.asset("assets/images/text.png"), flex: 1),
        Expanded(
          child: Stack(
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _firestore.collection('carts').snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    allDatas = snapshots.data!.docs;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: getProportionteScreenHeight(42.0),
                        left: getProportionScreenWidth(48.0),
                        right: getProportionScreenWidth(48.0),
                      ),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          int manyFood = 1;
                          return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                            stream: _firestore
                                .collection(
                                    snapshots.data!.docs[index]["name"][1])
                                .doc(snapshots.data!.docs[index]["name"][0])
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom:
                                          getProportionteScreenHeight(14.0)),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.0),
                                    color: snapshots
                                                .data!.docs[index]['name'][2]
                                                .toString()
                                                .replaceAll(
                                                    snapshots.data!.docs[index]
                                                        ['name'][0],
                                                    "") ==
                                            _authentication
                                                .authUser.currentUser!.uid
                                        ? Colors.white
                                        : Colors.black26,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: kBigIconColor,
                                      backgroundImage:
                                          NetworkImage(snapshot.data!['img']),
                                    ),
                                    title: Text(
                                      snapshot.data!['name'],
                                      style: TextStyle(
                                          fontSize: getProportionteScreenHeight(
                                              18.0)),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "\$ ${snapshot.data!['money']}.00",
                                            style: TextStyle(
                                                color: kPrimaryColor,
                                                fontSize:
                                                    getProportionteScreenHeight(
                                                        18.0)),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical:
                                                  getProportionteScreenHeight(
                                                      4.0),
                                              horizontal:
                                                  getProportionScreenWidth(
                                                      8.0)),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32.0),
                                            color: kPrimaryColor,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                  CupertinoIcons.minus,
                                                  color: Colors.white,
                                                  size:
                                                      getProportionteScreenHeight(
                                                          10.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        getProportionScreenWidth(
                                                            8.0)),
                                                child: Text(
                                                  "$manyFood",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize:
                                                          getProportionteScreenHeight(
                                                              12.0)),
                                                ),
                                              ),
                                              Icon(
                                                CupertinoIcons.plus,
                                                color: Colors.white,
                                                size:
                                                    getProportionteScreenHeight(
                                                        10.0),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                        },
                        itemCount: snapshots.data!.docs.length,
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              Positioned(
                bottom: getProportionteScreenHeight(38.0),
                left: 0.0,
                right: 0.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionScreenWidth(48.0)),
                  child: MyBotton(
                    title: "Complete order",
                    myOnPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SimpleDialog(
                            backgroundColor: kBackgroundColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0)),
                            title: Text(
                              "Please note",
                              style: TextStyle(
                                fontSize: getProportionteScreenHeight(22.0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            children: [
                              Container(
                                height: getProportionteScreenHeight(256.0),
                                padding: EdgeInsets.symmetric(
                                  horizontal: getProportionScreenWidth(42.0),
                                  vertical: getProportionteScreenHeight(18.0),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(32.0)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "DELIVERY TO TRASACO",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "\$ 2 - \$ 3",
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(child: Divider(), flex: 3),
                                    Text(
                                      "DELIVERY TO CAMPUS",
                                      style: TextStyle(
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w200),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "\$ 1",
                                      ),
                                      flex: 4,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionteScreenHeight(
                                                        8.0),
                                              ),
                                              child: Text(
                                                "Cencel",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              primary: Colors.black38,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrderPage(
                                                    allDatas: allDatas!,
                                                    
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical:
                                                    getProportionteScreenHeight(
                                                        8.0),
                                              ),
                                              child: Text(
                                                "Proceed",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: kPrimaryColor,
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(32.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          flex: 29,
        ),
      ],
    );
  }
}
