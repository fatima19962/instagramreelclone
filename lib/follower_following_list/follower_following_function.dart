import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';

class FollowerFollowingFunctions {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<UserModel>?> getFollowersFollowingData(
      String userUid, String collection) async {
    try {
      final result = await _firestore
          .collection("users")
          .doc(userUid)
          .collection(collection)
          .get();
      List<UserModel> userModels = [];
      for (var element in result.docs) {
        final user = await _firestore
            .collection("users")
            .doc(element.data()['uid'])
            .get();
        if (user.exists) {
          userModels.add(UserModel.fromJson(user.data()!));
        }
      }
      return userModels;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
