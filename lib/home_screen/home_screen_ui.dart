import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:instagramreelclone/home_screen/home_function.dart';
import 'package:instagramreelclone/home_screen/reel_view_screen_ui.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/login_screen/login_function.dart';
import 'package:instagramreelclone/model_classes/reels_model.dart';
import 'package:instagramreelclone/profile_screen/profile_screen_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ReelsModel> reelsModel = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getReelsData() async {
    reelsModel = await HomeFunctions.getReels() ?? [];
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        title: Text(
          "Reels",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       LoginFunctions.logout(context);
          //     },
          //     icon: Icon(Icons.logout)),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileScreen(
                              userUid: FirebaseAuth.instance.currentUser!.uid,
                            )),
                    // builder: (_) => ProfileScreen()),
                    (route) => false);
              },
              icon: Icon(Icons.account_circle))
        ],
      ),
      body: isLoading
          ? LoadingScreen()
          : PageView.builder(
              itemCount: reelsModel.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return ReelViewScreenUI(
                  reelsModel: reelsModel[index],
                );
              }),
    );
  }
}
