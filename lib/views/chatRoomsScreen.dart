

import 'package:chat_app_tutorial/helper/authenticate.dart';
import 'package:chat_app_tutorial/services/auth.dart';
import 'package:chat_app_tutorial/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  AuthMethods _authMethods = new AuthMethods();

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser == null ? Authenticate() : Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png',
          height: 50.0,),
        actions: [
          GestureDetector(
            onTap: (){
              _authMethods.signOut(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                left: 16.0
              ),
              child: Icon(Icons.exit_to_app_rounded),
            ),
          )
        ],
      ),

    );
  }
}
