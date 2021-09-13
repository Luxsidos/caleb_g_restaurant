import 'package:caleb_j_restaurant/constants.dart';
import 'package:caleb_j_restaurant/screens/get_started/components/body.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFFFF4B3A),
      body: Body()
    );
  }
}
