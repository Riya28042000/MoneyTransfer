import 'package:flutter/material.dart';

class Friends extends StatefulWidget {
  const Friends({ Key? key }) : super(key: key);

  @override
  _FriendsState createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {

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
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Text("Welcome to MoneyTranfer app", style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15, fontWeight: FontWeight.w900),),
               SizedBox(height: 20,),
                Text("You have not added any friends yet", style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 15, fontWeight: FontWeight.w500),),
               SizedBox(height: 20,),
                Center(child: ElevatedButton.icon(onPressed: null, icon: Icon(Icons.group, color: Colors.white,), label: Text('Add Friends from Contact List', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.white, fontWeight: FontWeight.w500 ),), style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.blue), ),)),
             ],
           ),
         ),
    );
  }
}