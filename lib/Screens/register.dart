import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moneytransfer/Screens/login.dart';
import 'package:moneytransfer/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> validatekey = GlobalKey<FormState>();
  String _email = '';
  String _pass = '';
  String name = '';
  late String val;
  bool passwordVisible = true;
  bool loading = false;
  String errorMessage = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final databaseReference = FirebaseFirestore.instance;

  signMeUp(String email, String pass, String name) async {
    if (validatekey.currentState!.validate()) {
      setState(() {
        loading = true;
      });

      await Auth.signUp(email, pass).then((value) {
        if (value != null) {
          databaseReference.collection("register").add({
            'name': name,
            'email': email,
          }).then((onValue) {
            setState(() {
              loading = false;
            });
            Alert(
              context: context,
              type: AlertType.success,
              title: "SUCCESS",
              style: AlertStyle(
                backgroundColor: Theme.of(context).cardColor,
                animationType: AnimationType.fromTop,
                isCloseButton: false,
                isOverlayTapDismiss: false,
                descStyle: TextStyle(fontSize: 18),
                animationDuration: Duration(milliseconds: 400),
                alertBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: BorderSide(
                      // color: Colors.grey,
                      ),
                ),
                titleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textSelectionColor),
              ),
              desc: "Registered Successfully!",
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
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                        (Route<dynamic> route) => false))
              ],
            ).show();
          });
        }
      }).catchError((onError) {
        print(onError);
        switch (onError.toString()) {
          case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':
            val = "Check your connection!";
            break;
          case 'PlatformException(ERROR_EMAIL_ALREADY_IN_USE, The email address is already in use by another account., null)':
            val = "User already registered!";
            break;
          default:
            val = "Something went wrong!";
        }

        Alert(
          context: context,
          type: AlertType.error,
          title: "ERROR",
          style: AlertStyle(
            animationType: AnimationType.fromTop,
            backgroundColor: Theme.of(context).cardColor,
            isCloseButton: false,
            isOverlayTapDismiss: false,
            descStyle: TextStyle(fontSize: 18),
            animationDuration: Duration(milliseconds: 400),
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  // color: Colors.grey,
                  ),
            ),
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textSelectionColor),
          ),
          desc: val,
          buttons: [
            DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop())
          ],
        ).show();
        setState(() {
          loading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
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
                          "Create Account",
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
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  name = value!;
                                },
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value) {
                                  _email = value!;
                                },
                                decoration: InputDecoration(
                                  labelText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                onSaved: (value) {
                                  _pass = value!;
                                },
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        passwordVisible = !passwordVisible;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              RaisedButton(
                                child: Text("Sign Up"),
                                onPressed: () {
                                  print(name);
                                  print(_email);
                                  validatekey.currentState!.save();
                                  if (_email.isEmpty) {
                                    _displaySnackBar(
                                        context, "Please enter your Email");
                                  } else if (!RegExp(
                                          r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(_email))
                                    _displaySnackBar(
                                        context, "Please Fill valid Email");
                                  else if (_pass.isEmpty)
                                    _displaySnackBar(
                                        context, "Please enter your Password");
                                  else if (name.isEmpty) {
                                    _displaySnackBar(
                                        context, "Please enter your Name");
                                  } else {
                                    signMeUp(_email, _pass, name);
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
