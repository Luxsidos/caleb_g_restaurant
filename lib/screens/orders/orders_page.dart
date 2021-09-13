import 'package:caleb_j_restaurant/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderPage extends StatelessWidget {
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? allDatas;
  OrderPage({
    Key? key,
    this.allDatas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(
        allDatas: allDatas,
        vaqt: 7,
      ),
    );
  }
}
