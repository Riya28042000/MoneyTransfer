import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moneytransfer/HelperFunctions/shared_preference.dart';
import 'package:moneytransfer/Screens/forgot_pass.dart';
import 'package:moneytransfer/Screens/home.dart';
import 'package:moneytransfer/Screens/navigation.dart';
import 'package:moneytransfer/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final validatekey = GlobalKey<FormState>();

  bool loading = false;
  String errorMessage = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final databaseReference = FirebaseFirestore.instance;
 String email= '';
 String password='';
  String val='';
  bool passwordVisible = true;
   
 
  signMeIn(String email, String pass) async {
    try {
      if (validatekey.currentState!.validate()) {
        setState(() {
          loading = true;
        });
      }
       HelperFunctions.saveUserLoggedInSharedPreference(true);
       
          HelperFunctions.saveUserEmailSharedPreference(email);
      final newuser = await Auth.signIn(email, password);
      if (newuser != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );

        setState(() {
          loading = false;
        });
      }
    } catch (onError) {
      print(onError);
      switch (onError.toString()) {
        case 'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)':
          val = "User Not Found!";
          break;
        case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':
          val = "Check your connection!";
          break;
        default:
          val = "Check your details!";
          break;
      }
      Alert(
        context: context,
        type: AlertType.error,
        title: "ERROR",
        style: AlertStyle(
          backgroundColor: Theme.of(context).cardColor,
          animationType: AnimationType.fromTop,
          isCloseButton: false,
          isOverlayTapDismiss: false,
          descStyle: TextStyle(fontFamily: 'Zilla Slab', fontSize: 18),
          animationDuration: Duration(milliseconds: 400),
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                // color: Colors.grey,
                ),
          ),
          titleStyle: TextStyle(
              fontFamily: 'Zilla Slab',
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textSelectionColor),
        ),
        desc: val,
        buttons: [
          DialogButton(
              color: Color(0xff3671a4),
              child: Text(
                "OK",
                style: TextStyle(
                    fontFamily: 'Zilla Slab',
                    fontSize: 20,
                    color: Colors.white),
              ),
              onPressed: () => Navigator.of(context).pop())
        ],
      ).show();
      print('error');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
      ),
      body: loading
          ? Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Welcome Back",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 36),
                        Form(
                          key: validatekey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                validator: (value) {
                                  if (value == null) {
                                    return "Enter Email";
                                  } else
                                    return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onSaved: (value) {
                                  email = value!;
                                },
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null) {
                                    return "Enter Password";
                                  } else
                                    return null;
                                },
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                        // Based on passwordVisible state choose the icon

                                        passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                                onSaved: (value) {
                                  password = value!;
                                },
                              ),
                              TextButton(
                                onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const ForgotPass()),
                        (Route<dynamic> route) => false);
                                  },
                                child: Text(
                                  "Forgot your password?",
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                             
                              ),
                              ElevatedButton(
                                child: Text("Sign In",style: TextStyle(color: Colors.white),),
                                onPressed: () {
                                  print(email);
                                  validatekey.currentState!.save();
                                  if (email.isEmpty) {
                                    _displaySnackBar(
                                        context, "Please enter your Email");
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(email))
                                    _displaySnackBar(
                                        context, "Please Fill valid Email");
                                  else if (password.isEmpty)
                                    _displaySnackBar(
                                        context, "Please enter your Password");
                                  else {
                                    signMeIn(email, password);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _displaySnackBar(BuildContext context, String a) {
    final snackBar = SnackBar(
      content: Text(a,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(color: Theme.of(context).primaryColor)),
      backgroundColor: Colors.black,
    );
    _scaffoldKey.currentState!.showSnackBar(snackBar);
  }
}
