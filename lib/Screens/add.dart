import 'package:flutter/material.dart';

class Add extends StatefulWidget {
  const Add({ Key? key }) : super(key: key);

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  Future<bool> _willPopCallback() async {

      return false;
}
String descr='';
String rupee='';
String email='';
    void _modalBottomSheetMenu(){
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (builder){
              return new Container(
                height: 350.0,
                color: Colors.transparent,
                child: new Container(
                    decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0))),
                    child: Column(
                       children: [
                         ListTile(title: Text('You paid, split Equally', style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.blue, fontWeight: FontWeight.w500 ),),leading: Icon(Icons.money),),
                          Divider(thickness: 0.5,),
                          ListTile(title: Text('You owed the full amount',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.blue ,fontWeight: FontWeight.w500 ),),leading: Icon(Icons.money),),
                           Divider(thickness: 0.5,),
                           ListTile(title: Text('Dummy paid, split equally',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.blue, fontWeight: FontWeight.w500 ),),leading: Icon(Icons.money),),
                            Divider(thickness: 0.5,),
                            ListTile(title: Text('Dummy owed the full amount',style: Theme.of(context).textTheme.headline1!.copyWith(fontSize:15, color: Colors.blue, fontWeight: FontWeight.w500 ),),leading: Icon(Icons.money),),
                      Divider(thickness: 0.5,),
                       ],

                    ),
                    ),
              );
            }
        );
      }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
         onWillPop: _willPopCallback,
         child: Scaffold(
           body: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               SizedBox(height:75,),
                Center(
                  child: Text(
                            "Add an Expense",
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Theme.of(context).primaryColor, fontSize: 40),
                          ),
                ),
                  SizedBox(height: 35),
                   Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Enter Description";
                                    } else
                                      return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    descr = value!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Enter Description",
                                    prefixIcon: Icon(Icons.description),
                                  ),
                                ),
                   ),
                              //SizedBox(height: 12),
                                Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Enter Expense";
                                    } else
                                      return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    rupee = value!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Enter Expense",
                                    prefixIcon: Icon(Icons.money)
                                  ),
                                ),
                   ),
                    Padding(
                     padding: const EdgeInsets.all(15.0),
                     child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Enter Email";
                                    } else
                                      return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Enter Email",
                                    prefixIcon: Icon(Icons.mail)
                                  ),
                                ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: ElevatedButton(onPressed:(){ _modalBottomSheetMenu();}, child: Text('Paid by you and split equally', style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue),),),
                   )
             ],
           ),
         ),
    );
  }
}