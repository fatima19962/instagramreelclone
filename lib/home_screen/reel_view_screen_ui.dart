import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramreelclone/comment_screen/comment_screen_ui.dart';
import 'package:instagramreelclone/home_screen/home_function.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/model_classes/reels_model.dart';
import 'package:instagramreelclone/profile_screen/profile_screen_ui.dart';
import 'package:video_player/video_player.dart';

class ReelViewScreenUI extends StatefulWidget {
  final ReelsModel reelsModel;

  ReelViewScreenUI({Key? key, required this.reelsModel}) : super(key: key);

  @override
  State<ReelViewScreenUI> createState() => _ReelViewScreenUIState();
}

class _ReelViewScreenUIState extends State<ReelViewScreenUI> {
  late VideoPlayerController videoPlayerController;
  bool isAlreadyLiked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseVideoPlayer();
    checkIfAlreadyLiked();
  }

  void initialiseVideoPlayer() {
    videoPlayerController =
        VideoPlayerController.network(widget.reelsModel.videoLink!);
    videoPlayerController.initialize().then((value) {
      videoPlayerController.play();
      setState(() {});
    });
  }

  void checkIfAlreadyLiked() async {
    isAlreadyLiked = await HomeFunctions.isAlreadyLiked(widget.reelsModel.id!);
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
            child: videoPlayerController.value.isInitialized
                ? VideoPlayer(videoPlayerController)
                : LoadingScreen(),
          ),
          Positioned(
            left: 60.w,
            bottom: 80.h,
            child: Text(
              widget.reelsModel.username!,
              style: TextStyle(color: Colors.black, fontSize: 16.sp),
            ),
          ),
          Positioned(
            left: 10.w,
            bottom: 72.h,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen(userUid: widget.reelsModel.uid!),
                  ),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(widget.reelsModel.profileImage!),
              ),
            ),
          ),
          Positioned(
            left: 10.w,
            bottom: 10.h,
            child: Container(
              height: 60.h,
              width: 200.w,
              child: Text(
                widget.reelsModel.title!,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          Positioned(
            right: 15.w,
            bottom: 220.h,
            child: IconButton(
              onPressed: () {
                if (isAlreadyLiked) {
                  setState(() {
                    widget.reelsModel.likes = widget.reelsModel.likes! - 1;
                    isAlreadyLiked = false;
                  });
                  HomeFunctions.onLikeAndUnLike(widget.reelsModel.id!, true);
                } else {
                  setState(() {
                    widget.reelsModel.likes = widget.reelsModel.likes! + 1;
                    isAlreadyLiked = true;
                  });
                  HomeFunctions.onLikeAndUnLike(widget.reelsModel.id!, true);
                }
              },
              icon: Icon(
                Icons.heart_broken,
                size: 30.sp,
                color: isAlreadyLiked ? Colors.pink : Colors.black,
              ),
            ),
          ),
          Positioned(
            right: 25.w,
            bottom: 210.h,
            child: Container(
              alignment: Alignment.center,
              width: 20.w,
              child: Text(
                widget.reelsModel.likes.toString(),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            right: 15.w,
            bottom: 150.h,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentScreen(
                        reelId: widget.reelsModel.id!,
                      ),
                    ));
              },
              icon: Icon(
                Icons.comment,
                size: 30.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
