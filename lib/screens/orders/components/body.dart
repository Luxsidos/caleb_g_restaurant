import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/models/my_botton.dart';
import 'package:caleb_j_restaurant/models/my_no_data.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  int? vaqt;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? allDatas;
  Body({Key? key, this.allDatas, this.vaqt}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  Authentication _authentication = Authentication();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  AnimationController? _animationController;

  bool aniqla = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: widget.vaqt!));

    _animationController!.forward();
    _animationController!.addListener(() {
      setState(() {
        finish();
      });
    });

    dbGet();
  }

  dbGet() async {
    QuerySnapshot<Map<String, dynamic>> data =
        await _firestore.collection('carts').get();
    for (QueryDocumentSnapshot<Map<String, dynamic>> item in data.docs) {
      if (item['name'][2] == _authentication.authUser.currentUser!.uid) {
        aniqla = true;
        setState(() {});
        dbDelete();
        break;
      }
    }
  }

  dbDelete() async {
    if (aniqla) {
      QuerySnapshot<Map<String, dynamic>> data =
          await _firestore.collection('carts').get();
      for (var i = 0; i < data.docs.length; i++) {
        if (data.docs[i]['name'][2] ==
            _authentication.authUser.currentUser!.uid) {
          String id = data.docs[i].id;
          await _firestore.collection('carts').doc(id).delete();
          setState(() {});
        }
      }
    }
  }

  finish() {
    if (_animationController!.value >= 1.0) {
      
      setState(() {
        aniqla = false;
      });
      showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("XABAR!"),
            children: [
              Container(
                height: getProportionteScreenHeight(138.0),
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionScreenWidth(42.0),
                  vertical: getProportionteScreenHeight(18.0),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(32.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: getProportionteScreenHeight(12.0),
                        horizontal: getProportionScreenWidth(12.0),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor,
                      ),
                      child: Icon(
                        CupertinoIcons.check_mark,
                        size: getProportionteScreenHeight(32.0),
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "Mahsulot Yetkazib Berildi!",
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          fontSize: getProportionteScreenHeight(20.0)),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    }
  }

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
              "Orders",
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
          child: aniqla
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: getProportionteScreenHeight(42.0),
                    left: getProportionScreenWidth(48.0),
                    right: getProportionScreenWidth(48.0),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: Colors.white,
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/loading_gif.gif"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        flex: 7,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: getProportionteScreenHeight(14.0)),
                        child: Text(
                          "being sent...",
                          style: TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22.0),
                        child: Container(
                          height: getProportionteScreenHeight(24.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.0),
                            color: kPrimaryColor,
                          ),
                          padding: EdgeInsets.only(
                              left: (MediaQuery.of(context).size.width -
                                      getProportionScreenWidth(96)) *
                                  _animationController!.value),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 4,
                      ),
                      MyBotton(
                        title: "Back",
                        myOnPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              : MyNoData(
                  icon: Image.asset("assets/icons/korzinka.png"),
                  title: "No orders yet",
                  content:
                      "Hit the orange button down below to Create an order",
                  buttonTitle: "Start ordering",
                ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}

/*
 widget.allDatas![2]['name'][2] ==
                  _authentication.authUser.currentUser!.uid
              ? 
              
              
              : 
*/