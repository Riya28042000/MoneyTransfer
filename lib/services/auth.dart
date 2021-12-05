import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

 class Auth {


  static Future<User> signIn(String email, String password) async {
       final FirebaseAuth auth = FirebaseAuth.instance;
     UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;
    return user;
  }

  static Future<User> signUp(String email, String password) async {
       final FirebaseAuth auth = FirebaseAuth.instance;
   UserCredential result =
        await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;
    return user;
  }


   static Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

 static Future<User> getCurrentUser() async {
    final User user = FirebaseAuth.instance.currentUser!;
    return user;
  }



  static Future<void> resetPassword(email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}