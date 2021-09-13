import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/models/myAppBar.dart';
import 'package:caleb_j_restaurant/screens/home/components/menuScreen.dart';
import 'package:caleb_j_restaurant/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'components/body.dart';

class HomePage extends StatefulWidget {
  var zoomController;
  HomePage({Key? key, this.zoomController}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Body(
        zoomController: widget.zoomController,
      ),
    );
  }
}
