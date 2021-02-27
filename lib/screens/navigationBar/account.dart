import 'dart:convert';
import 'package:bengtravel/screens/model/user_model.dart';
import 'package:bengtravel/screens/utility/my_constant.dart';
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:bengtravel/screens/utility/signout_process.dart';
import 'package:bengtravel/screens/widget/add_travel.dart';
import 'package:bengtravel/screens/widget/edit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String nameUser, urlPicture;
  double scree;
  bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data
  List<UserModel> userModels = List();
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
    readDataUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }

  Future<Null> readDataUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    nameUser = preferences.getString('Name');
    String url =
        '${MyConstant().domain}/bengtravel/PHP/getUserWhereId.php?isAdd=true&id=$id';

    await Dio().get(url).then((value) {
      print('Value ===>>> $value');

      var result = json.decode(value.data);
      print('Result ===>>> $result');
      for (var map in result) {
        setState(() {
          userModel = UserModel.fromJson(map);
        });
        print('Name ===>>>${userModel.name}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    scree = MediaQuery.of(context).size.width;
    return Scaffold(
      body: userModel == null
          ? MyStyle().showProgress()
          : Container(
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  MyStyle().showTextStyle3('บัญชีผู้ใช้'),
                  userModel == null
                      ? MyStyle().showProgress()
                      : userModel.urlPicture.isEmpty
                          ? buildAccountImage()
                          : buildAccountImageUpdate(),
                  userModel == null
                      ? MyStyle().showProgress()
                      : userModel.name.isEmpty
                          ? buildListTileName()
                          : buildListTileNameUpdate(),
                  buildListTileEdit(),
                  buildListTileAddTravel(),
                  buildListTileLogOut(),
                ],
              ),
            ),
    );
  }

  ListTile buildListTileLogOut() {
    return ListTile(
      onTap: () => signOutProcess(context),
      leading: Icon(Icons.settings_power),
      title: Text(
        'ออกจากระบบ',
      ),
    );
  }

  ListTile buildListTileAddTravel() {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddTravel(),
          ),
        );
      },
      leading: Icon(Icons.add_box_outlined),
      title: Text(
        'เพิ่มสถานที่ท้องเที่ยว',
      ),
    );
  }

  ListTile buildListTileEdit() {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Edit(),
          ),
        );
      },
      leading: Icon(Icons.edit_sharp),
      title: Text(
        'แก้ไขข้อมูล',
      ),
    );
  }

  ListTile buildListTileName() {
    return ListTile(
      leading: Icon(Icons.account_box),
      title: Text(
        '$nameUser',
      ),
    );
  }

  ListTile buildListTileNameUpdate() {
    return ListTile(
      leading: Icon(Icons.account_box),
      title: Text(
        '${userModel.name}',
      ),
    );
  }

  Widget buildAccountImage() => Container(
        margin: EdgeInsets.only(top: 10),
        width: scree * 0.4,
        child: Image.asset('images/account.png'),
      );

  Widget buildAccountImageUpdate() => Container(
        decoration: BoxDecoration(),
        margin: EdgeInsets.only(top: 10),
        width:  125,
        height: 125,
        child: CircleAvatar(
          backgroundImage:
              NetworkImage('${MyConstant().domain}${userModel.urlPicture}',),
        ),
      );
}
