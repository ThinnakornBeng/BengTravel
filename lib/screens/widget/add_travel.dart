import 'dart:io';
import 'dart:math';
import 'package:bengtravel/screens/utility/my_constant.dart';
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:bengtravel/screens/utility/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTravel extends StatefulWidget {
  @override
  _AddTravelState createState() => _AddTravelState();
}

class _AddTravelState extends State<AddTravel> {
  double screen;
  double lat, lng;
  String nameTravel, detail, urlImage;
  File file;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findLatLng();
  }

  Future<Null> findLatLng() async {
    LocationData locationData = await findLocationData();
    setState(() {
      lat = locationData.latitude;
      lng = locationData.longitude;
    });
    print('lat===> $lat  lng ===> $lng');
  }

  Future<LocationData> findLocationData() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildBack(context),
            buildImageTravel(),
            buildIconButtonAddPhotoAndcamera(),
            buildTextFieldNameTravel(),
            detailFrom(),
            lat == null ? MyStyle().showProgress() : buildContainerShowMap(),
            buildRaisedSaveButton(),
          ],
        ),
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('Travel'),
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(
            title: 'ตำแหน่งของคุณ', snippet: 'ละติจุด  =$lat, ลองติจุด =$lng'),
      )
    ].toSet();
  }

  Container buildContainerShowMap() {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      margin: EdgeInsets.only(top: 15, right: 10, left: 10),
      height: 250,
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {},
        markers: myMarker(),
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

  Widget buildTextFieldNameTravel() {
    screen = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.black12),
      child: TextField(
        onChanged: (value) => nameTravel = value.trim(),
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

  Widget detailFrom() => Container(
        margin: EdgeInsets.only(top: 20),
        width: screen * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.black12),
        child: TextField(
          onChanged: (value) => detail = value.trim(),
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.star),
              labelText: 'รายละเอียด',
              border: InputBorder.none),
        ),
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
        margin: EdgeInsets.only(top: 15),
        width: screen * 0.7,
        child: RaisedButton(
          color: MyStyle().primaryColor,
          onPressed: () {
            if (nameTravel == null ||
                nameTravel.isEmpty ||
                detail == null ||
                detail.isEmpty) {
              normalDialog(context, 'กรุณากรอกข้อมูลให้ครบทุกช่อง');
            } else if (file == null) {
              normalDialog(context, 'กรุณาเลือกรูปภาพ');
            } else {
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
    String nameImage = 'travel$i.jpg';
    print('nameImage = $nameImage, pathImage = ${file.path}');

    String url = '${MyConstant().domain}/bengtravel/saveTravel.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(file.path, filename: nameImage);

      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('Response ===>>> $value');
        urlImage = '/bengtravel/Travel/$nameImage';
        print('UrlImage ===>>> $url');
        saveUploadTravel();
      });
    } catch (e) {}
  }

  Future<Null> saveUploadTravel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String idName = preferences.getString('id');
    print('idName ====>>>> $idName');
    String url =
        '${MyConstant().domain}/bengtravel/PHP/addtravel.php?isAdd=true&idName=$idName&NameTravel=$nameTravel&Detail=$detail&UrlImage=$urlImage&Lat=$lat&Lng=$lng';
    print('Url ====>>>> $url');
    await Dio().get(url).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'กรุณาลองใหม่ไม่สามารถบันทึกข้อมูลได้');
      }
    });
  }

  Widget buildImageTravel() => Container(
        margin: EdgeInsets.only(top: 20),
        width: screen * 0.5,
        height: 200,
        child:
            file == null ? Image.asset('images/image.png') : Image.file(file),
      );
}
