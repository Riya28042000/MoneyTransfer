import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moneytransfer/Screens/login.dart';
import 'package:moneytransfer/Screens/register.dart';
// import 'package:tabs/screens/home.dart';
// import 'package:tabs/screens/login.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          "Money Transfer",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          "The expense sharing app.",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(height: 120),
                        Image(
                          image: AssetImage(
                            'assets/moneyt.png',
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                             ElevatedButton(
                                child: Text("Create Account"),
                                onPressed: () {
                              
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            Register()),
                                    ModalRoute.withName('/'),
                                  );
                                },
                              ),
                              TextButton(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            Login()),
                                    ModalRoute.withName('/'),
                                  );
                                },
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
