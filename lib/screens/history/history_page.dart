import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/material.dart';

import 'body/body.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
