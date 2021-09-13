import 'package:cached_network_image/cached_network_image.dart';
import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/models/navigationBar.dart';
import 'package:caleb_j_restaurant/screens/cart/cart_page.dart';
import 'package:caleb_j_restaurant/screens/home/components/detail_page.dart';
import 'package:caleb_j_restaurant/screens/orders/orders_page.dart';
import 'package:caleb_j_restaurant/screens/search/search_page.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  var zoomController;
  Body({Key? key, this.zoomController}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  TabController? _tabBarController;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CollectionReference<Object>>? allDatas;
  
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allDatas = [
      _firestore.collection('foods'),
      _firestore.collection('drinks'),
      _firestore.collection('snacks'),
      _firestore.collection('sauces'),
    ];
    _tabBarController = TabController(length: allDatas!.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyAppBar(
            myLeading: IconButton(
              icon: ImageIcon(
                AssetImage("assets/icons/Vector1.png"),
                size: getProportionteScreenHeight(32.0),
              ),
              onPressed: () {
                widget.zoomController.toggle();
              },
            ),
            myTrailing: IconButton(
              icon: Icon(
                CupertinoIcons.shopping_cart,
                color: Colors.black45,
                size: getProportionteScreenHeight(26.0),
              ),
              onPressed: () {
                
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionScreenWidth(48.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delicious food for you",
                  style: TextStyle(
                    fontSize: getProportionteScreenHeight(34.0),
                    shadows: [
                      Shadow(
                        offset: Offset(0.0, 3.0),
                        blurRadius: 3.0,
                        color: Colors.black45,
                      )
                    ],
                  ),
                ),
                SizedBox(height: getProportionteScreenHeight(24.0)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(allDatas: allDatas),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: getProportionteScreenHeight(18.0),
                        horizontal: getProportionScreenWidth(18.0)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      color: kSearchColor,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Icon(
                            CupertinoIcons.search,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                          child: Text(
                            "Search",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: getProportionteScreenHeight(18.0)),
                          ),
                          flex: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: getProportionScreenWidth(48.0)),
            child: TabBar(
              physics: BouncingScrollPhysics(),
              onTap: (e) {
                setState(() {
                  currentIndex = e;
                });
              },
              isScrollable: true,
              labelColor: kPrimaryColor,
              indicatorColor: kPrimaryColor,
              unselectedLabelColor: Colors.black45,
              controller: _tabBarController,
              tabs: allDatas!.map((e) {
                return Tab(
                  text: e.id,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: getProportionScreenWidth(40.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(
                    "see more",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: getProportionteScreenHeight(16.0)),
                  ),
                  style: TextButton.styleFrom(primary: kPrimaryColor),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: StreamBuilder<QuerySnapshot>(
                stream: allDatas![currentIndex].snapshots(),
                builder: (context, snapshots) {
                  if (snapshots.hasData) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: getProportionScreenWidth(52.0)),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                      foodData: snapshots.data!.docs,
                                      collectionFood: allDatas![currentIndex].id,
                                      currentIndex: index),
                                ),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          getProportionScreenWidth(28.0)),
                                  margin: EdgeInsets.only(
                                      top: getProportionteScreenHeight(58.0),
                                      bottom:
                                          getProportionteScreenHeight(16.0)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 20.0,
                                          color: Colors.grey.shade300,
                                          offset: Offset(0.0, 2.0),
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Spacer(
                                        flex: 8,
                                      ),
                                      Expanded(
                                        child: Text(
                                          snapshots.data!.docs[index]['name']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize:
                                                getProportionteScreenHeight(
                                                    28.0),
                                          ),
                                        ),
                                        flex: 2,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "\$ ${snapshots.data!.docs[index]['money']}.00",
                                          style:
                                              TextStyle(color: kPrimaryColor, fontSize: getProportionteScreenHeight(20.0)),
                                        ),
                                        flex: 5,
                                      ),
                                    ],
                                  ),
                                  width: 220.0,
                                ),
                                CachedNetworkImage(
                                  imageUrl:
                                      "${snapshots.data!.docs[index]['img']}",
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                    backgroundImage: imageProvider,
                                    backgroundColor: kSearchColor,
                                    radius: getProportionteScreenHeight(86.0),
                                  ),
                                  placeholder: (context, url) => CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: CircularProgressIndicator(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshots.data!.docs.length,
                    );
                  }
                  if (snapshots.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Text("Error");
                },
              ),
            ),
          ),
          MyNavigationBar(),
        ],
      ),
    );
  }
}

/*

*/
