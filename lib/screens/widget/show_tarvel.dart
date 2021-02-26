import 'package:bengtravel/screens/model/travel_model.dart';
import 'package:flutter/material.dart';

class ShowTravel extends StatefulWidget {
  final TravelModel travelModel;
  ShowTravel({Key key, this.travelModel}) : super(key: key);
  @override
  _ShowTravelState createState() => _ShowTravelState();
}

class _ShowTravelState extends State<ShowTravel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('ShowTravelApp'),),);
  }
}
