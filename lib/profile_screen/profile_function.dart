import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramreelclone/model_classes/reels_model.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';

class ProfileFunction {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // static Future<UserModel?> getUserDetails() async {
  static Future<UserModel?> getUserDetails(String userUid) async {
    try {
      final result = await _firestore
          .collection('users')
          // .doc(_auth.currentUser!.uid)
          .doc(userUid)
          .get();
      // final result = await _firestore.collection('users').doc(userUid).get();
      UserModel userModel = UserModel.fromJson(result.data()!);
      return userModel;
      // return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> onFollowAndUnFollow(
      bool isFollow, String profileUserUid) async {
    try {
      final currentUserProfileReference =
          _firestore.collection("users").doc(_auth.currentUser!.uid);
      final profileUserProfileRefrence =
          _firestore.collection("users").doc(profileUserUid);
      final currentUserFollowerRefrence = _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .collection("following")
          .doc(profileUserUid);
      final profileUserFollowerRefrence = _firestore
          .collection("users")
          .doc(profileUserUid)
          .collection("followers")
          .doc(_auth.currentUser!.uid);
      await currentUserFollowerRefrence.set({"uid": profileUserUid});
      await profileUserFollowerRefrence.set({"uid": _auth.currentUser!.uid});
      await _firestore.runTransaction((transaction) async {
        final profileUser = await transaction.get(profileUserProfileRefrence);
        final currentUser = await transaction.get(currentUserProfileReference);
        int profileUserFollowerCount = profileUser['followers'];
        int currentUserFollowingCount = currentUser['following'];
        if (isFollow) {
          transaction.update(profileUserProfileRefrence,
              {"followers": profileUserFollowerCount + 1});
          transaction.update(currentUserProfileReference, {
            "following": currentUserFollowingCount + 1,
          });
          transaction.set(currentUserFollowerRefrence, {"uid": profileUserUid});
          transaction.set(
              profileUserFollowerRefrence, {"uid": _auth.currentUser!.uid});
        } else {
          transaction.update(profileUserProfileRefrence,
              {"followers": profileUserFollowerCount - 1});
          transaction.update(currentUserProfileReference, {
            "following": currentUserFollowingCount - 1,
          });
          transaction.delete(currentUserFollowerRefrence);
          transaction.delete(profileUserFollowerRefrence);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<bool> checkIfAlreadyFollowed(String profileUserUid) async {
    try {
      final result = await _firestore
          .collection("users")
          .doc(profileUserUid)
          .collection("followers")
          .doc(_auth.currentUser!.uid)
          .get();
      return result.exists;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // static Future<List<ReelsModel>?> getUserReels() async {
  static Future<List<ReelsModel>?> getUserReels(String userUid) async {
    try {
      final result = await _firestore
          .collection("reels")
          .where("uid", isEqualTo: userUid)
          // .where("uid", isEqualTo: _auth.currentUser!.uid)
          .get();
      List<ReelsModel> reelModel = [];
      reelModel =
          result.docs.map((e) => ReelsModel.fromJson(e.data())).toList();
      print(reelModel[0].username);
      return reelModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
