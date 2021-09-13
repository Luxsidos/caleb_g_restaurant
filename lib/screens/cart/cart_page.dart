import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class CartPage extends StatelessWidget {
  String? collectionFood;
  CartPage({Key? key, this.collectionFood}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(
        collectionFood: collectionFood,
      ),
    );
  }
}
