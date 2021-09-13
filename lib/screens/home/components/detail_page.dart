import 'package:cached_network_image/cached_network_image.dart';
import 'package:caleb_j_restaurant/authentication/auth.dart';
import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/models/my_botton.dart';
import 'package:caleb_j_restaurant/screens/cart/cart_page.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  List<QueryDocumentSnapshot>? foodData;
  String? collectionFood;
  int? currentIndex;
  DetailPage({Key? key, this.foodData, this.currentIndex, this.collectionFood})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool heart = false;
  PageController? _pageController;
  int? _currentIndex1;
  Authentication _authentication = Authentication();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex!);
    _currentIndex1 = widget.currentIndex!;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyAppBar(
              myLeading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              myTrailing: IconButton(
                icon: Icon(
                  !heart ? CupertinoIcons.heart : CupertinoIcons.heart_fill,
                ),
                onPressed: () {
                  setState(() {
                    heart = !heart;
                  });
                },
              ),
            ),
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (e) {
                  setState(() {
                    _currentIndex1 = e;
                  });
                },
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.foodData![index]['img'],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        color: kSearchColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => CircleAvatar(
                      backgroundColor: Colors.white,
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  );
                },
                itemCount: widget.foodData!.length,
              ),
              flex: 8,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.foodData!.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionScreenWidth(8.0),
                      ),
                      child: CircleAvatar(
                        backgroundColor: _currentIndex1 == index
                            ? kPrimaryColor
                            : kBigIconColor,
                        radius: getProportionteScreenHeight(4.0),
                      ),
                    );
                  },
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.foodData![_currentIndex1!]['name'].toString(),
                    style: TextStyle(
                      fontSize: getProportionteScreenHeight(28.0),
                    ),
                  ),
                  Text(
                    "\$ ${widget.foodData![_currentIndex1!]['money']}.00",
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: getProportionteScreenHeight(22.0)),
                  ),
                ],
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionScreenWidth(48.0),
                  vertical: getProportionteScreenHeight(42.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Delivery info",
                      style: TextStyle(
                        fontSize: getProportionteScreenHeight(18.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Delivered between monday aug and thursday 20 from 8pm to 91:32 pm",
                        style: TextStyle(
                          fontSize: getProportionteScreenHeight(14.0),
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    Text(
                      "Return policy",
                      style: TextStyle(
                        fontSize: getProportionteScreenHeight(18.0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "All our foods are double checked before leaving our stores so by any case you found a broken food please contact our hotline immediately.",
                        style: TextStyle(
                          fontSize: getProportionteScreenHeight(14.0),
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    MyBotton(
                      title: "Add to cart",
                      myOnPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Waiting..."),
                          ),
                        );
                        await _firestore
                            .collection('carts')
                            .doc(widget.foodData![_currentIndex1!]['name']
                                .toString() + _authentication.authUser.currentUser!.email!)
                            .set(
                          {
                           "name": FieldValue.arrayUnion(
                              [
                                widget.foodData![_currentIndex1!]['name']
                                    .toString(),
                                widget.collectionFood,
                                _authentication.authUser.currentUser!.uid,
                              ],
                            ),
                          },
                          SetOptions(merge: true),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CartPage(
                              collectionFood: widget.collectionFood,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              flex: 12,
            ),
          ],
        ),
      ),
    );
  }
}

/*

*/