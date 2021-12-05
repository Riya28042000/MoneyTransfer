import 'package:flutter/material.dart';
import 'package:moneytransfer/Screens/login.dart';
import 'package:moneytransfer/Screens/register.dart';
import 'package:moneytransfer/services/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final validatekey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  bool isLoading = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

reset(String email) async {
  
setState(() {
      isLoading=true;
    });
   if (validatekey.currentState!.validate()) {
 validatekey.currentState!.reset();
  print(_email.text);
      await Auth.resetPassword(_email.text).then((onValue){
         setState(() {
      isLoading=false;
    });
        Alert(
            context: context,
            
            type: AlertType.success,
            title: "PASSWORD RESET",
            style:AlertStyle(
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
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Check your Email to reset Password!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false),
              )
            ],
          ).show();
       print('email sent');
      }).catchError((onError){
        switch(onError.toString()){
   case 'PlatformException(ERROR_USER_NOT_FOUND, There is no user record corresponding to this identifier. The user may have been deleted., null)':{
      Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      backgroundColor: Theme.of(context).cardColor,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontFamily:'Zilla Slab',fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
         // color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(fontFamily:'Zilla Slab',
        fontWeight: FontWeight.bold,
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Please Register Yourself!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontFamily:'Zilla Slab',fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>  Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Register()),
        (Route<dynamic> route) => false),
              )
            ],
          ).show();
        setState(() {
          isLoading=false;
        });
   }
   break;
   case 'PlatformException(ERROR_NETWORK_REQUEST_FAILED, A network error (such as timeout, interrupted connection or unreachable host) has occurred., null)':{
           Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      backgroundColor: Theme.of(context).cardColor,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontFamily:'Zilla Slab',fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
         // color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(fontFamily:'Zilla Slab',
        fontWeight: FontWeight.bold,
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Check your connection!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontFamily:'Zilla Slab',fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>  Navigator.of(context).pop()
              )
            ],
          ).show();
        setState(() {
          isLoading=false;
        });
   }
        break;
        default:{
                Alert(
            context: context,
            
            type: AlertType.error,
            title: "ERROR",
            style:AlertStyle(
      animationType: AnimationType.fromTop,
      backgroundColor: Theme.of(context).cardColor,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontFamily:'Zilla Slab',fontSize: 18),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(
         // color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(fontFamily:'Zilla Slab',
        fontWeight: FontWeight.bold,
       color: Theme.of(context).textSelectionColor
      ),
    ),
            desc: "Someting went wrong!",
            buttons: [
              DialogButton(
                color: Color(0xff3671a4),
                child: Text(
                  "OK",
                  style: TextStyle(fontFamily:'Zilla Slab',fontSize: 20,color: Colors.white),
                ),
                onPressed: () =>  Navigator.of(context).pop()
              )
            ],
          ).show();
        setState(() {
          isLoading=false;
        });
        }
        
        }
                print(onError);
     
      });
   }
   
}
   String email='';
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Form(
                  key: validatekey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Forgot Your Password?",
                          style: Theme.of(context).textTheme.headline4),
                      SizedBox(height: 8),
                      Text(
                        "Enter your email and we'll send you instructions.",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: 36),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _email,
                        validator: (value) {
                          if (value == null) {
                            return "Enter Username";
                          } else
                            return null;
                        },
                         onSaved: (value) {
                          email = value!;
                          setState(() {
                            
                          });
                        },
                        onChanged: (val)=>{
                          email=val,
                           setState(() {
                            
                          })
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                      ),
                      
                      SizedBox(height: 12),
                      ElevatedButton(
                        child: Text("Submit"),
                        onPressed:()=> reset(email),
                      ),
                    ],
                  ),
                )
             
        ),
      ),
    );
  }
}