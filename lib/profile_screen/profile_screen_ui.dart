import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramreelclone/follower_following_list/follower_following_screen_ui.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/login_screen/login_function.dart';
import 'package:instagramreelclone/model_classes/reels_model.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';
import 'package:instagramreelclone/profile_screen/profile_function.dart';
import 'package:instagramreelclone/profile_update_screen/profile_update_screen.dart';
import 'package:instagramreelclone/reels_upload_screen/reels_upload_screen_ui.dart';

import 'package:instagramreelclone/search_screen/search_screen_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class ProfileScreen extends StatefulWidget {
  final String userUid;

  //
  ProfileScreen({Key? key, required this.userUid}) : super(key: key);

  // const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userModel;

  bool isAlreadyFollowed = false;

  bool get isCurrentUser =>
      FirebaseAuth.instance.currentUser!.uid == widget.userUid;

  List<ReelsModel> reelModel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserDetails();
  }

  void getCurrentUserDetails() async {
    userModel = await ProfileFunction.getUserDetails(widget.userUid);
    // userModel = await ProfileFunction.getUserDetails();
    isAlreadyFollowed =
        await ProfileFunction.checkIfAlreadyFollowed(widget.userUid);
    reelModel = await ProfileFunction.getUserReels(widget.userUid) ?? [];
    // getCurrentUserReels();
    print(userModel!.name);
    setState(() {});
  }

  // void getCurrentUserReels() async {
  //   reelModel = await ProfileFunction.getUserReels() ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: userModel == null
          ? LoadingScreen()
          : Scaffold(
              body: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // "Username",
                            userModel!.username!,
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReelsUploadScreen(
                                          userModel: userModel!,
                                        )),
                              );
                            },
                            icon: Icon(Icons.add),
                          ),
                          IconButton(
                            onPressed: () {
                              showSearch(
                                context: context,
                                delegate: SearchScreenUI(),
                              );
                              ;
                            },
                            icon: Icon(Icons.search),
                          ),
                          IconButton(
                              onPressed: () {
                                LoginFunctions.logout(context);
                              },
                              icon: Icon(Icons.logout)),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 90.h,
                            width: 90.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                              image: DecorationImage(
                                image: NetworkImage(userModel!.profileImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          showDetails(
                              "Posts", userModel!.posts!.toString(), null),
                          showDetails(
                            "Followers",
                            userModel!.followers!.toString(),
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FollowerFollowingScreen(
                                          title: "Followers",
                                          userUid: userModel!.uid!,
                                          // userUid: userModel!.uid,
                                        )),
                              );
                            },
                          ),
                          showDetails(
                              "Following", userModel!.following!.toString(),
                              () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FollowerFollowingScreen(
                                        title: "Following",
                                        userUid: userModel!.uid!,
                                      )),
                            );
                          }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userModel!.name!,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userModel!.bio!,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () async {
                            Uri uri = Uri.parse(userModel!.addLink!);
                            if (await canLaunchUrl(uri)) {
                              launchUrl(uri);
                            } else {
                              print("can not launch url");
                            }
                          },
                          child: Text(
                            userModel!.addLink!,
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    customButton(isCurrentUser),
                    SizedBox(
                      height: 30.h,
                    ),
                    Expanded(
                      child: GridView.builder(
                        itemCount: reelModel.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          // return SizedBox(
                          //   child: Image.network(
                          //       "https://image.petmd.com/files/styles/863x625/public/orange-tabby-kitten-walking-across-floor.jpg?w=1080&q=75",
                          //       fit: BoxFit.fill),
                          // );
                          return VideoThumbnail(reelsModel: reelModel[index]);
                          //return VideoPlayer(VideoPlayerController.network(
                          //   reelModel[index].videoLink!,
                          // ));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget customButton(bool isCurrentUserProfile) {
    return InkWell(
      onTap: () {
        if (isCurrentUserProfile) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProfileUpdateScreen(
                userModel: userModel!,
              ),
            ),
          );
        } else {
          //  follow functionality

          if (isAlreadyFollowed) {
            setState(() {
              userModel!.followers = userModel!.followers! - 1;
              isAlreadyFollowed = false;
            });
            ProfileFunction.onFollowAndUnFollow(false, widget.userUid);
          } else {
            setState(() {
              userModel!.followers = userModel!.followers! + 1;
              isAlreadyFollowed = true;
            });
            ProfileFunction.onFollowAndUnFollow(true, widget.userUid);
          }
        }
      },
      child: Container(
        height: 30.h,
        width: 310.w,
        decoration: BoxDecoration(
          color: isCurrentUserProfile ? Colors.grey[100] : Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
            isCurrentUserProfile
                ? "Edit Profile"
                : isAlreadyFollowed
                    ? "UnFollow"
                    : "Follow",
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isCurrentUserProfile ? Colors.black : Colors.white)),
      ),
    );
  }

  Widget showDetails(String title, String value, ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Text(value,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w500)),
          Text(title,
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }
}

class VideoThumbnail extends StatefulWidget {
  final ReelsModel reelsModel;

  VideoThumbnail({Key? key, required this.reelsModel}) : super(key: key);

  @override
  State<VideoThumbnail> createState() => _VideoThumbnailState();
}

class _VideoThumbnailState extends State<VideoThumbnail> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = VideoPlayerController.network(
      widget.reelsModel.videoLink!,
    );
    videoPlayerController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(videoPlayerController);
  }
}
