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
  bool statusRedEye = true;

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
  Widget build(
    BuildContext context,
  ) {
    screen = MediaQuery.of(context).size.width;
    screen = MediaQuery.of(context).size.height;
    return travelModels == null
        ? MyStyle().showProgress()
        : ListView.builder(
            itemCount: travelModels.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                print('You Click index $index');
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => ShowTravel(
                    travelModel: travelModels[index],
                  ),
                );
                Navigator.push(context, route);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: Image.network(
                          '${MyConstant().domain}${travelModels[index].urlImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.4,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    travelModels[index].nameTravel,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                travelModels[index].detail,
                                style: TextStyle(fontSize: 17),
                              ),
                              // Row(
                              //   children: [
                              //     IconButton(
                              //         icon: statusRedEye
                              //             ? Icon(Icons.thumb_up)
                              //             : Icon(
                              //                 Icons.thumb_up_sharp,
                              //                 color: Colors.blue,
                              //               ),
                              //         onPressed: () {
                              //           print('You Click index $index');
                              //           setState(() {
                              //             statusRedEye = !statusRedEye;
                              //           });
                              //         }),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
