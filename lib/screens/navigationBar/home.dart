import 'dart:convert';
import 'package:bengtravel/screens/model/travel_model.dart';
import 'package:bengtravel/screens/utility/my_constant.dart';
import 'package:bengtravel/screens/utility/my_style.dart';
import 'package:bengtravel/screens/widget/show_tarvel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screen;
  List<TravelModel> travelModels = List();
  List<Widget> shopCards = List();
  int index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTravel();
  }

  Future<Null> readTravel() async {
    String url =
        '${MyConstant().domain}/bengtravel/PHP/getUserWhereTravel.php?isAdd=true';
    await Dio().get(url).then((value) {
      print('value = $value');
      var result = json.decode(value.data);
      for (var map in result) {
        TravelModel travelModel = TravelModel.fromJson(map);

        String nameTravel = travelModel.nameTravel;
        if (nameTravel.isNotEmpty) {
          print('nameTravel = ${travelModel.nameTravel}');
          setState(() {
            travelModels.add(travelModel);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    screen = MediaQuery.of(context).size.height;
    return travelModels == 0
        ? MyStyle().showProgress()
        : ListView.builder(
            itemCount: travelModels.length,
            itemBuilder: (context, index) => Row(
              children: <Widget>[
                Container(padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height:MediaQuery.of(context).size.width * 0.4,
                  child: Image.network(travelModels[index].pathImage,fit: BoxFit.cover,),
                ),
                Text(travelModels[index].nameTravel),
              ],
            ),
          );
  }
}
