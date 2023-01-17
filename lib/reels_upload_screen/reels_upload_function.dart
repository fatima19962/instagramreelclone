import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagramreelclone/model_classes/reels_model.dart';

class ReelsUploadFunction {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<void> postReel(ReelsModel reelsModel) async {
    try {
      _firestore
          .collection("reels")
          .doc(reelsModel.id)
          .set(reelsModel.toJson());
      print("Reel uploaded Successfully");
    } catch (e) {
      print(e);
    }
  }

  static Future<String?> uploadVideo(File videoFile, String videoName) async {
    try {
      final refrence = _storage.ref().child("reels/$videoName.png");
      final uploadTask = refrence.putFile(videoFile);
      await uploadTask.whenComplete(() {});
      String downloadurl = await refrence.getDownloadURL();
      return downloadurl;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
