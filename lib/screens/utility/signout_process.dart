import 'package:bengtravel/screens/authentication.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> signOutProcess(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  // exit(0);
  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => Authentication(),
  );
  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
