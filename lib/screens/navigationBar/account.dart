import 'dart:convert';

import 'package:bengtravel/screens/authentication.dart';
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
  String nameUser;
  double scree;
   bool loadStatus = true; // Process Load JSON
  bool status = true; // Have Data
  List<UserModel> userModels = List();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('Name');
    });
  }

    Future<Null> readFoodMenu() async {
    if (userModels.length != 0) {
      userModels.clear();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    print('id = $id');

    String url =
        '${MyConstant().domain}/bengfood/getfoodwhereidshop.php?isAdd=true&idShop=$id';
    await Dio().get(url).then((value) {
      setState(() {
        loadStatus = false;
      });

      if (value.toString() != 'null') {
        print('varlue ==>> $value');

        var result = json.decode(value.data);
        print('result ==>> $result');

        for (var map in result) {
          UserModel userModel = UserModel.fromJson(map);
          setState(() {
            userModels.add(userModel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    scree = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            MyStyle().showTextStyle3('บัญชีผู้ใช้'),
            buildAccountImage(),
            buildListTileName(),
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

  Widget buildAccountImage() => Container(
        margin: EdgeInsets.only(top: 10),
        width: scree * 0.4,
        child: Image.asset('images/account.png'),
      );
}
