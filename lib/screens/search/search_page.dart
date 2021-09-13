import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  List<CollectionReference<Object>>? allDatas;
  SearchPage({Key? key, this.allDatas}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> foodsName = ["foods", 'drinks', 'snacks', 'sauces'];
  var allFoods = [];
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  List foundFoods = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future findFoods() async {
    for (String food in allFoods) {
      for (int i = 0; i < food.length; i++) {
        if (!foundFoods.contains(food)) {
          if (_searchController.text
              .toLowerCase()
              .contains(food[i].toLowerCase())) {
            foundFoods.add(food);
            setState(() {});
          }
        }
      }
      for (int i = 0; i < _searchController.text.length; i++) {
        if (!food
            .toLowerCase()
            .contains(_searchController.text[i].toLowerCase())) {
          foundFoods.remove(food);
          setState(() {});
        }
      }
      setState(() {});
    }
    if (_searchController.text.isEmpty) {
      foundFoods = [];
      setState(() {});
    }
  }

  Future getData() async {
    for (String name in foodsName) {
      QuerySnapshot<Map<String, dynamic>> data =
          await _firestore.collection(name).get();
      for (var i = 0; i < data.docs.length; i++) {
        allFoods.add(data.docs[i]['name']);
      }
    }

    print(allFoods);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyAppBar(
              myLeading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: getProportionteScreenHeight(24.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              myTitle: Expanded(
                child: Container(
                  child: TextFormField(
                    onChanged: (e) {
                      findFoods();
                    },
                    onEditingComplete: () {
                      findFoods();
                    },
                    controller: _searchController,
                    cursorColor: kTextColor,
                    decoration: InputDecoration(
                        hintText: "Search...",
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(32.0)),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: getProportionteScreenHeight(36.0),
                      left: getProportionScreenWidth(34.0),
                      right: getProportionScreenWidth(34.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Found ${foundFoods.length} results",
                        style: TextStyle(fontSize: 28.0),
                      ),
                      SizedBox(height: getProportionteScreenHeight(16.0)),
                      Expanded(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {},
                              title: Text(
                                foundFoods[index],
                                style: TextStyle(
                                    fontSize:
                                        getProportionteScreenHeight(24.0)),
                              ),
                              leading: Icon(
                                Icons.breakfast_dining,
                                color: kPrimaryColor,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            );
                          },
                          itemCount: foundFoods.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
