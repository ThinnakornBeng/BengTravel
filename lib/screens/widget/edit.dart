import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:flutter/material.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  double screen;
  bool statusRedEye = true;
  String name, password, urlPicture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  Future<Null> readUserModel()async {}

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
              onPressed: null),
          IconButton(
              icon: Icon(
                Icons.add_photo_alternate_outlined,
                size: 30,
              ),
              onPressed: null),
        ],
      );

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
        margin: EdgeInsets.only(top: 200),
        width: screen * 0.7,
        child: RaisedButton(
          color: MyStyle().primaryColor,
          onPressed: () {},
          child: Text(
            'บันทึก',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
      );

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
        child: Image.asset('images/account.png'),
      );
}
