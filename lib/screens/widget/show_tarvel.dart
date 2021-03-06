import 'package:bengtravel/screens/model/travel_model.dart';
import 'package:bengtravel/screens/utility/my_api.dart';
import 'package:bengtravel/screens/utility/my_constant.dart';
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class ShowTravel extends StatefulWidget {
  final TravelModel travelModel;
  ShowTravel({Key key, this.travelModel}) : super(key: key);
  @override
  _ShowTravelState createState() => _ShowTravelState();
}

class _ShowTravelState extends State<ShowTravel> {
  TravelModel travelModel;
  double lat1, lng1, lat2, lng2, distance;
  String distanceString;
  int transport;
  CameraPosition position;

  @override
  void initState() {
    super.initState();
    travelModel = widget.travelModel;
    findLat1Lng1();
  }
   Future<Null> findLat1Lng1() async {
    LocationData locationData = await findLocationDate();
    setState(() {
      lat1 = locationData.latitude;
      lng1 = locationData.longitude;
      lat2 = double.parse(travelModel.lat);
      lng2 = double.parse(travelModel.lng);
      print('Lat1 = $lat1, Lng1 = $lng1, Lat2 = $lat2, Lng2 = $lng2');
      distance = MyAPI().calculateDistance(lat1, lng1, lat2, lng2);

      var myFormat = NumberFormat('##0.0#', 'en_US');
      distanceString = myFormat.format(distance);

      print('distance = $distance');
      print('transport = $transport');
    });
  }



   Future<LocationData> findLocationDate() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(travelModel.nameTravel),),body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(16.0),
                width: 250.0,
                height: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: NetworkImage(
                        '${MyConstant().domain}${travelModel.urlImage}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.amber,
              size: 35.0,
            ),
            title: Text(
              'รายละเอียด ${travelModel.detail}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),  
          showMap()
        ],
      ),);
  }

  Container showMap() {
    if (lat1 != null) {
      LatLng latLng1 = LatLng(lat1, lng1);
      position = CameraPosition(
        target: latLng1,
        zoom: 16.0,
      );
    }

    Marker userMarker() {
      return Marker(
        markerId: MarkerId('UserMarker'),
        position: LatLng(lat1, lng1),
        icon: BitmapDescriptor.defaultMarkerWithHue(60.0),
        infoWindow: InfoWindow(title: 'ตำแหน่งของฉัน'),
      );
    }

    Marker shopMarker() {
      return Marker(
        markerId: MarkerId('UserMarker'),
        position: LatLng(lat2, lng2),
        icon: BitmapDescriptor.defaultMarkerWithHue(120.0),
        infoWindow: InfoWindow(title: travelModel.nameTravel),
      );
    }

    Set<Marker> mySet() {
      return <Marker>[userMarker(), shopMarker()].toSet();
    }

    return Container(
      margin: EdgeInsets.all(16.0),
      height: 300.0,
      child: lat1 == null
          ? MyStyle().showProgress()
          : GoogleMap(
              initialCameraPosition: position,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: mySet(),
            ),
    );
  }
}
