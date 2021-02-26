import 'package:bengtravel/screens/navigationBar/account.dart';
import 'package:bengtravel/screens/navigationBar/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexNavigationBar extends StatefulWidget {
  @override
  _IndexNavigationBarState createState() => _IndexNavigationBarState();
}

class _IndexNavigationBarState extends State<IndexNavigationBar> {
  List<Widget> listWidgets = [Home(), Account()];
  int indexPage = 0;
  String nameUser;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listWidgets[indexPage],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  BottomNavigationBar bottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: Colors.yellow.shade800,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        items: <BottomNavigationBarItem>[
          homeNva(),
          accountNva(),
        ],
      );

  BottomNavigationBarItem homeNva() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      title: Text(
        'Home',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  BottomNavigationBarItem accountNva() {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.account_circle,
      ),
      title: Text(
        'Account',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
