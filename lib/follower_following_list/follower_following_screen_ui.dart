import 'package:flutter/material.dart';
import 'package:instagramreelclone/follower_following_list/follower_following_function.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';
import 'package:instagramreelclone/profile_screen/profile_screen_ui.dart';

class FollowerFollowingScreen extends StatefulWidget {
  final String title;
  final String userUid;

  FollowerFollowingScreen(
      {Key? key, required this.title, required this.userUid})
      : super(key: key);

  @override
  State<FollowerFollowingScreen> createState() =>
      _FollowerFollowingScreenState();
}

class _FollowerFollowingScreenState extends State<FollowerFollowingScreen> {
  List<UserModel> userModel = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    userModel = await FollowerFollowingFunctions.getFollowersFollowingData(
          widget.userUid,
          widget.title.toLowerCase(),
        ) ??
        [];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          // "Followers",
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: isLoading
          ? LoadingScreen()
          : ListView.builder(
              itemCount: userModel.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfileScreen(userUid: userModel[index].uid!),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        NetworkImage(userModel[index].profileImage!),
                  ),
                  title: Text(userModel[index].username!),
                );
              }),
    );
  }
}
