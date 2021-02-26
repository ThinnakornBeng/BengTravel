import 'package:flutter/material.dart';

class MyStyle {
  double screen;
  Color darkColor = Color(0xffc6a700);
  Color lightColor = Color(0xffffff6b);
  Color primaryColor = Color(0xfffcd734);

  Container buildLogo() {
    return Container(
      width: 150,
      child: Image.asset('images/travellogo.png'),
    );
  }

  Text showTextStyle1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          color: MyStyle().darkColor,
          fontWeight: FontWeight.w300,
        ),
      );

  Text showTextStyle2(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          color: MyStyle().lightColor,
          fontWeight: FontWeight.w300,
        ),
      );

  Text showTextStyle3(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      );

  Text showTextStyle4(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      );

  Text showTextStyle5(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 24,
          color: Colors.black54,
          fontWeight: FontWeight.w900,
        ),
      );

  SizedBox mySizebox() => SizedBox(
        width: 8.0,
        height: 16.0,
      );

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  MyStyle();
}
