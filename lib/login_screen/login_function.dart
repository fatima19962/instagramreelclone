import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:instagramreelclone/authentication/authentication.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';
import 'package:instagramreelclone/shared_prefrences/shared_preference.dart';


class LoginFunctions {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        await getUserDetails();
        return true;
      } else {
        return false;
      }
    } on FirebaseAuthException catch (e) {
      // return e.message;
      return false;
    }
    // }catch(e){
    //   print(e);
    //   return false;
    // }
  }

  static Future<void> getUserDetails() async {
    try {
      final result = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();
      UserModel userModel = UserModel.fromJson(result.data()!);
      await SharedPrefrencesHelper.saveString("uid", userModel.uid!);
      await SharedPrefrencesHelper.saveString("username", userModel.username!);
      await SharedPrefrencesHelper.saveString(
          "profile_image", userModel.profileImage!);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> logout(BuildContext context) async {
    await _auth.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => Authentication()),
          (route) => false);
    });
  }
}
