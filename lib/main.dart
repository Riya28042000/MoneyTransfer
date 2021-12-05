import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:moneytransfer/HelperFunctions/shared_preference.dart';
import 'package:moneytransfer/Screens/home.dart';
import 'package:moneytransfer/Screens/navigation.dart';
import 'package:moneytransfer/Screens/welcome.dart';
import 'package:moneytransfer/Scrollglow/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneytransfer/services/auth.dart';
Future<void> main() async {
// To display application in potrait mode only
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) { runApp(MyApp());
   
  });
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn= false;
   @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value!;
        print(value);
      });
    });
  //   HelperFunctions.saveAdminLoggedInSharedPreference(false);
  }

   @override
  Widget build(BuildContext context) {
     final Color primaryColor = Colors.blue;
  final Color accentColor = Color(0xff333333);
    return MaterialApp(
            builder: (context, child) {

        //Remove Scroll Glow from our App
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: accentColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white),
          fontFamily: 'Rubik',
          textTheme: TextTheme(
            headline4:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            headline3: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            button: TextStyle(color: Colors.white),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: primaryColor,
            textTheme: ButtonTextTheme.normal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding: EdgeInsets.all(8),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      title: 'Money_Transfer',
            debugShowCheckedModeBanner: false,            
            home: userIsLoggedIn? BottomNavBar() :Welcome()
          );
         
        
     
    
  }
}