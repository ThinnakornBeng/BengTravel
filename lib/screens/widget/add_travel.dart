
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddTravel extends StatefulWidget {
  @override
  _AddTravelState createState() => _AddTravelState();
}

class _AddTravelState extends State<AddTravel> {
  double screen;
  String nameTravel, detail, pathImage;
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildBack(context),
            buildImageTravel(),
            buildIconButtonAddPhotoAndcamera(),
            buildTextFieldNameTravel(),
            buildTextFieldDetail(),
            buildContainerShowMap(),
            buildRaisedSaveButton(),
          ],
        ),
      ),
    );
  }

  Container buildContainerShowMap() {
     LatLng latLng = LatLng(14.916077, 102.757241);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );

    return Container(margin: EdgeInsets.only(top: 15,right: 10,left: 10),
      height: 250,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        
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

  Widget buildTextFieldNameTravel() {
    screen = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Name',
            icon: Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.details,
                )),
            border: InputBorder.none),
      ),
    );
  }

  Widget buildTextFieldDetail() {
    screen = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        decoration: InputDecoration(
            hintText: 'Detail',
            icon: Container(
                margin: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.details,
                )),
            border: InputBorder.none),
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

  Widget buildRaisedSaveButton() => Container(
        margin: EdgeInsets.only(top: 15),
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

  Widget buildImageTravel() => Container(
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.5,
      child: Image.asset('images/image.png'));
}
