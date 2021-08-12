

import 'package:chat_app_tutorial/helper/authenticate.dart';
import 'package:chat_app_tutorial/modal/user.dart';
import 'package:chat_app_tutorial/views/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser _userFromFirebaseUser(User user){

    return user != null ? AppUser(userId: user.uid) : null;
  }
  // Sign in user
  Future signInWithEmailAndPassword(String email, String password) async{

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User firebaseuser = userCredential.user;

      return _userFromFirebaseUser(firebaseuser);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  // Register user
  Future signUpWithEmailAndPassword(String email, String password) async{

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User firebaseuser = userCredential.user;

      return _userFromFirebaseUser(firebaseuser);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // Reset password

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }
    catch(e){
      print(e.toString());
    }
  }

  Future signOut(BuildContext context) async{
    try{
      await _auth.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Authenticate()));
    }
    catch(e){
      print(e.toString());
    }
  }

}