import 'dart:convert';
import 'package:bengtravel/screens/admin.dart';
import 'package:bengtravel/screens/model/user_model.dart';
import 'package:bengtravel/screens/navigationBar/index_nva.dart';
import 'package:bengtravel/screens/register.dart';
import 'package:bengtravel/screens/utility/my_constant.dart';
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:bengtravel/screens/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool statusRedEye = true;
  double screen;
  String user, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkPreferance();
  }

  Future<Null> checkPreferance() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String type = preferences.getString('Type');
      if (type != null && type.isNotEmpty) {
        if (type == 'User') {
          roteToSevice(IndexNavigationBar());
        } else {
          normalDialog(context, 'Error User Type');
        }
      }
    } catch (e) {}
  }

  void roteToSevice(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: Center(
          child: buildColumn(),
        ),
      ),
    );
  }

  Widget buildColumn() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().buildLogo(),
          MyStyle().showTextStyle5('Travel Application'),
          buildTextFieldEmail(),
          buildTextFieldPassword(),
          buildRaisedLoginButton(),
          buildTextButtonRegister(),
        ],
      ),
    );
  }

  Widget buildRaisedLoginButton() => Container(
        margin: EdgeInsets.only(top: 10),
        width: screen * 0.7,
        child: RaisedButton(
          color: MyStyle().primaryColor,
          onPressed: () {
            if (user == null ||
                user.isEmpty ||
                password == null ||
                user.isEmpty) {
              normalDialog(context, 'มีช่องว่างกรุณากรอกข้อมูลให้ครบ');
            } else {
              checkAuten();
            }
          },
          child: Text('Login'),
        ),
      );

  Future<Null> checkAuten() async {
    String url =
        '${MyConstant().domain}/bengtravel/PHP/check_user.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result = $result');
      for (var map in result) {
        print(result);
        UserModel userModel = UserModel.fromJson(map);

        if (password == userModel.password) {
          print(password);
          String type = userModel.type;
          if (type == 'User') {
            // routeToApp(IndexNavigationBar(), userModel);
            routeToApp(IndexNavigationBar(),userModel);
          } else if (type == 'Admin') {
            routeToApp(Admin(), userModel);
          } else {
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'รหัสผ่านไม่ถูกต้องกรุณาลองใหม่');
        }
      }
    } catch (e) {}
  }

  Future<Null> routeToApp(Widget myWidget, UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModel.id);
    preferences.setString('Type', userModel.type);
    preferences.setString('Name', userModel.name);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget buildTextButtonRegister() => TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Register()));
        },
        child: Text('Register'),
      );

  Widget buildTextFieldEmail() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'User',
            icon: Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.email_outlined,
                )),
            border: InputBorder.none),
      ),
    );
  }

  Widget buildTextFieldPassword() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        decoration: InputDecoration(
            hintText: 'Password',
            icon: Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(Icons.lock_outlined)),
            border: InputBorder.none,
            suffixIcon: IconButton(
                icon: statusRedEye
                    ? Icon(Icons.visibility_off_rounded)
                    : Icon(Icons.visibility_rounded),
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                })),
      ),
    );
  }
}
