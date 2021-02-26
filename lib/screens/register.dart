import 'package:bengtravel/screens/authentication.dart';
import 'package:bengtravel/screens/utility/my_constant.dart';
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:bengtravel/screens/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String name, user, password;
  bool statusRedEye = true;
  double screen;
  String type = 'User';
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBack(context),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: buildColumn()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildBack(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  Widget buildColumn() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().buildLogo(),
          MyStyle().showTextStyle3('Register for TravelApplication'),
          buildTextFieldName(),
          buildTextFieldEmail(),
          buildTextFieldPassword(),
          buildRaisedSaveButton(),
        ],
      ),
    );
  }

  Widget buildRaisedSaveButton() => Container(
        margin: EdgeInsets.only(top: 10),
        width: screen * 0.7,
        child: RaisedButton(
          color: MyStyle().primaryColor,
          onPressed: () {
            if (name == null ||
                name.isEmpty ||
                user == null ||
                user.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'กรุณาใส่ข้อมูลการสัครให้ครบถ้วน');
            } else {
              cheeckUser();
            }
          },
          child: Text(
            'บันทึก',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      );

  Future<Null> cheeckUser() async {
    String url =
        '${MyConstant().domain}/bengtravel/PHP/check_user.php?isAdd=true&User=$user';
    try {
      Response response = await Dio().get(url);
      if (response.toString() == 'null') {
        registerThead();
      } else {
        normalDialog(context, 'user : $user มีอยู่ในระบบแล้วกรุณาสมัครใหม่');
      }
    } catch (e) {}
  }

  Future<Null> registerThead() async {
    String url =
        '${MyConstant().domain}/bengtravel/PHP/register.php?isAdd=true&Name=$name&Type=$type&User=$user&Password=$password';
    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString() == 'true') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Authentication(),
            ));
      } else {
        normalDialog(context, 'ไม่สามารถสมัครได้ กรุณาลองใหม่อีกคร้้ง');
      }
    } catch (e) {}
  }

  Widget buildTextFieldName() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
            hintText: 'Name',
            icon: Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.account_box_rounded,
                )),
            border: InputBorder.none),
      ),
    );
  }

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
              child: Icon(Icons.lock_outlined),
            ),
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
