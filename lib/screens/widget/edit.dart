import 'dart:io';
import 'dart:math';

import 'package:bengtravel/screens/utility/my_constant.dart';
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:bengtravel/screens/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  double screen;
  bool statusRedEye = true;
  String name, password, urlPicture;
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<Null> readUserModel() async {}

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBack(context),
            MyStyle().showTextStyle3('แก้ไขบัญชีผู้ใช้'),
            buildImageAccount(),
            buildIconButtonAddPhotoAndcamera(),
            buildTextFieldName(),
            buildTextFieldPassword(),
            buildRaisedSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget buildIconButtonAddPhotoAndcamera() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.add_a_photo_rounded,
              size: 30,
            ),
            onPressed: () => chooseImage(ImageSource.camera),
          ),
          IconButton(
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              size: 30,
            ),
            onPressed: () => chooseImage(ImageSource.gallery),
          ),
        ],
      );

  Future<Null> chooseImage(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
        maxHeight: 1000.0,
        maxWidth: 1000.0,
      );

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
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

  Widget buildRaisedSaveButton() => Container(
        margin: EdgeInsets.only(top: 15),
        width: screen * 0.7,
        child: RaisedButton(
          color: MyStyle().primaryColor,
          onPressed: () {
            if (name == null ||
                name.isEmpty ||
                password == null ||
                password.isEmpty) {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
            } else  {
              uploadImage();
            }
          },
          child: Text(
            'บันทึก',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      );

  Future<Null> uploadImage() async {
    Random random = Random();
    int i = random.nextInt(1000000);
    String nameImage = 'user$i.jpg';
    print('nameImage = $nameImage, pathImage = ${file.path}');

    String url = '${MyConstant().domain}/bengtravel/saveUser.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ===>>> $value');
        urlPicture = '/bengtravel/User/$nameImage';
        print('UrlImage ===>>> $url');
        saveUploadTravel();
      });
    } catch (e) {}
  }

  Future<Null> saveUploadTravel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    String url =
        '${MyConstant().domain}/bengtravel/PHP/editUser.php?isAdd=true&id=$id&Name=$name&Password=$password&UrlPicture=$urlPicture';
    print('Url ====>>>> $url');
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ไม่สามารถบันทึกข้อมูลได้');
      }
    });
  }
  Widget buildTextFieldName() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
            hintText: 'Thinnakorn Sathorn',
            icon: Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.account_box_rounded,
                )),
            border: InputBorder.none),
      ),
    );
  }

  Widget buildTextFieldPassword() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        decoration: InputDecoration(
            hintText: '**************',
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

  Widget buildImageAccount() => Container(
        margin: EdgeInsets.only(top: 20),
        width: screen * 0.4,
        child:  file == null ? Image.asset('images/account.png') : Image.file(file),
      );
}
