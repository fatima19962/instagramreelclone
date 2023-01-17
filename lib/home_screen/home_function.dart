import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramreelclone/model_classes/reels_model.dart';

class HomeFunctions {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<List<ReelsModel>?> getReels() async {
    try {
      final result = await _firestore.collection("reels").get();
      List<ReelsModel> reelModel = [];
      reelModel =
          result.docs.map((e) => ReelsModel.fromJson(e.data())).toList();
      return reelModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> onLikeAndUnLike(String reelId) async {
    try {
      final reelReference = _firestore.collection("reels").doc(reelId);
      final reelLikeReference = _firestore
          .collection("reels")
          .doc(reelId)
          .collection("likes")
          .doc(_auth.currentUser!.uid);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
