import 'package:caleb_j_restaurant/screens/get_started/get_started.dart';
import 'package:caleb_j_restaurant/screens/home/myHomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication {
  FirebaseAuth authUser = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future userSignUp(email, password, context) async {
    try {
      await authUser.createUserWithEmailAndPassword(
          email: email, password: password);
      await _firestore.collection("carts").get();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("such an email is available"),
        ),
      );
    }
  }

  Future userLogin(email, password, context) async {
    try {
      await authUser.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("no such email is available"),
        ),
      );
    }
  }

  Future userSignOut(context) async {
    try {
      await authUser.signOut();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GetStarted()),
      );
    } catch (e) {
      SnackBar(
        content: Text("did not come out"),
      );
    }
  }
}
