import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';

//
// class SearchFunctions {
//   static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   static Future<List<UserModel>?> searchUsers(String query) async {
//     try {
//       final result = await _firestore
//           .collection("users")
//           .where("username", isGreaterThanOrEqualTo: query)
//           .get();
//       List<UserModel> userModels = [];
//
//       userModels =
//           result.docs.map((e) => UserModel.fromJson(e.data())).toList();
//       return userModels;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
// }
