import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';
import 'package:instagramreelclone/profile_screen/profile_screen_ui.dart';
import 'package:instagramreelclone/search_screen/search_screen_function.dart';

class SearchScreenUI extends SearchDelegate {
  // List<UserModel> userModel = [];

  CollectionReference firebaseFirestore =
      FirebaseFirestore.instance.collection("users");

  // CollectionReference firebaseFirestore = FirebaseFirestore.instance
  //     .collection("users")
  //     .doc('uil')
  //     .collection(collectionPath);

  // void searchUser() async {
  //   userModel = [];
  //   userModel = await SearchFunctions.searchUsers(query) ?? [];
  // }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.close),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    // return Text("Result");
    // SearchFunctions.searchUsers(query);
    // searchUser();
    // return ListView.builder(
    //     // itemCount: 1,
    //     itemCount: userModel.length,
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         onTap: () {},
    //         leading: CircleAvatar(
    //           backgroundColor: Colors.grey,
    //         ),
    //         title: Text(userModel[index].username!),
    //       );
    //     });

    // return StreamBuilder<QuerySnapshot>(
    //     stream: firebaseFirestore.snapshots().asBroadcastStream(),
    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //       if (!snapshot.hasData) {
    //         return Center(child: CircularProgressIndicator());
    //       } else {
    //         if (snapshot.data!.docs
    //             .where((QueryDocumentSnapshot<Object?> element) =>
    //                 element['username']
    //                     .toString()
    //                     .toLowerCase()
    //                     .contains(query.toLowerCase()))
    //             .isEmpty) {
    //           return Center(
    //             child: Text("No search query found"),
    //           );
    //         } else {
    //           ///  fetch data here
    //
    //           print(snapshot.data);
    //           return ListView(children: <Widget>[
    //             ...snapshot.data!.docs
    //                 .where((QueryDocumentSnapshot<Object?> element) =>
    //                     element['username']
    //                         .toString()
    //                         .toLowerCase()
    //                         .contains(query.toLowerCase()))
    //                 .map((QueryDocumentSnapshot<Object?> data) {
    //               final String username = data.get('username');
    //               final String image = data['profile_image'];
    //               final String bio = data['bio'];
    //
    //               return ListTile(
    //                 onTap: () {
    //                   Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => ProfileScreen(
    //                               userUid: (snapshot.data! as dynamic)
    //                                   .docs[index]['uid'])));
    //                   // MaterialPageRoute(
    //                   //     builder: (_) => ProfileScreen(
    //                   //           // userUid: (snapshot.data! as dynamic)
    //                   //           //     .docs[index]['uid'],
    //                   //           userUid: userModel[index].uid,
    //                   //         )));
    //                 },
    //                 title: Text(username),
    //                 leading: CircleAvatar(
    //                   backgroundImage: NetworkImage(image),
    //                 ),
    //                 subtitle: Text(bio),
    //               );
    //             })
    //           ]);
    //         }
    //       }
    //     });

    return StreamBuilder<QuerySnapshot>(
        stream: firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['username']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("No search query found"),
              );
            } else {
              ///  fetch data here

              print(snapshot.data);
              // return ListView(children: <Widget>[
              //   ...snapshot.data!.docs
              //       .where((QueryDocumentSnapshot<Object?> element) =>
              //           element['username']
              //               .toString()
              //               .toLowerCase()
              //               .contains(query.toLowerCase()))
              //       .map((QueryDocumentSnapshot<Object?> data) {
              // final String username = data.get('username');
              // final String image = data['profile_image'];
              // final String bio = data['bio'];
              return ListView.builder(
                  itemCount: (snapshot.data! as dynamic).docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(
                            userUid: (snapshot.data! as dynamic).docs[index]
                                ['uid'],
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            (snapshot.data! as dynamic).docs[index]
                                ['profile_image'],
                          ),
                          radius: 16,
                        ),
                        title: Text(
                          (snapshot.data! as dynamic).docs[index]['username'],
                        ),
                      ),
                    );
                  });
              // ]);
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // searchUser();
    return Center(child: Text("Search anything here"));
    // return Text("Suggestions");
    // return ListView.builder(
    //     // itemCount: 5,
    //     itemCount: userModel.length,
    //     itemBuilder: (context, index) {
    //       return ListTile(
    //         onTap: () {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (_) => ProfileScreen(),
    //             ),
    //           );
    //         },
    //         leading: CircleAvatar(
    //           backgroundColor: Colors.grey,
    //           backgroundImage: NetworkImage(userModel[index].profileImage!),
    //         ),
    //         title: Text(userModel[index].username!),
    //       );
    //     });
  }
}
