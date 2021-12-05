
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:moneytransfer/Screens/add.dart';
import 'package:moneytransfer/Screens/friends.dart';
import 'package:moneytransfer/Screens/home.dart';

class BottomNavBar extends StatefulWidget {


  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    Friends(),
    Add(),
    Home(),
 
  ];
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: 50.0,
        items: <Widget>[
          Icon(Icons.group, size: 30, color: Colors.black),
          Icon(Icons.add, size: 30, color: Colors.black),
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
         
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            
          });
        },
      ),
      body: _children[_currentIndex],
    );
  }
}