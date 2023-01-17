import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';

class ProfileUpdateFunction {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // static FirebaseAuth _auth = FirebaseAuth.instance;
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> updateUserProfile(
      Map<String, dynamic> UserDetails) async {
    // static Future<void>updateUserProfile(UserModel userModel) async{
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          // .doc(UserDetails['uid'])
          // .doc(userModel.uid)
          // .update(userModel.toJson());
          .update(UserDetails);
      print("User Details Updated Successfully");
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadImage(File imageFile, String imageName) async {
    try {
      final refrence = _storage.ref().child("images/$imageName.png");
      final uploadTask = refrence.putFile(imageFile);
      await uploadTask.whenComplete(() {});
      String downloadurl = await refrence.getDownloadURL();
      return downloadurl;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
