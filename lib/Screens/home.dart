//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytransfer/HelperFunctions/shared_preference.dart';
// import 'package:provider/provider.dart';
// import 'package:tabs/controllers/tabsController.dart';
// import 'package:tabs/screens/create.dart';
// import 'package:tabs/screens/settings.dart';
// import 'package:tabs/services/auth.dart';
// import 'package:tabs/tabsContainer.dart';
import 'dart:io' show Platform;

import 'package:moneytransfer/Screens/welcome.dart';



class Home extends StatelessWidget {
  Future<bool> _willPopCallback() async {

      return false;
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Color(0xfffefefe),
        body: Column(
          children: [
            SizedBox(height: 30),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.logout),
                  onPressed: ()async {
                    
                    HelperFunctions.saveUserLoggedInSharedPreference(false);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Welcome()),
                        (Route<dynamic> route) => false);
                    
                  },
                ),
              ),
               SizedBox(height:15,),
                Center(
                  child: Text(
                            "Recent Activity",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Theme.of(context).primaryColor, fontSize: 40),
                          ),
                ),
                  SizedBox(height: 35),

                ListTile(title: Text('You added Dummy', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.black, fontWeight: FontWeight.w500 ),),leading: Icon(Icons.money),
                subtitle: Text('You recieve/send \$15', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.black, fontWeight: FontWeight.w100 ),),
                ),
                Divider(thickness: 0.5,),
                  ListTile(title: Text('You added Dummy', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.black, fontWeight: FontWeight.w500 ),),leading: Icon(Icons.money),
                subtitle: Text('You recieve/send \$20', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.black, fontWeight: FontWeight.w100 ),),
                ), 
                Divider(thickness: 0.5,),
          ],
        ) ),
    );}}