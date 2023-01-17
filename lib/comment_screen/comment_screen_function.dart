import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramreelclone/model_classes/comments_model.dart';

class CommentFunction {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> postComment(
      String reelId, CommentsModel commentsModel) async {
    try {
      await _firestore
          .collection("reels")
          .doc(reelId)
          .collection("comments")
          .doc(commentsModel.id)
          .set(commentsModel.toJson());
    } catch (e) {
      print(e);
      // return null;
    }
  }

  static Future<List<CommentsModel>?> getAllReelComments(String reelId) async {
    try {
      final result = await _firestore
          .collection("reels")
          .doc(reelId)
          .collection("comments")
          .get();
      List<CommentsModel> commentsModel = [];
      commentsModel =
          result.docs.map((e) => CommentsModel.fromJson(e.data())).toList();
      return commentsModel;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
