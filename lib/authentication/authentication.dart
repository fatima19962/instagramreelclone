import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramreelclone/home_screen/home_screen_ui.dart';
import 'package:instagramreelclone/login_screen/login_screenui.dart';

class Authentication extends StatelessWidget {
   Authentication({Key? key}) : super(key: key);
   FirebaseAuth _auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
   if(_auth.currentUser !=null){
       return HomeScreen();
   }else{
     return LoginScreenUI();
   }
  }
}
