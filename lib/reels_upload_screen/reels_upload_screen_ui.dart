import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramreelclone/const.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/model_classes/reels_model.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';
import 'package:instagramreelclone/reels_upload_screen/reels_upload_function.dart';
import 'package:video_player/video_player.dart';

class ReelsUploadScreen extends StatefulWidget {
  final UserModel userModel;

  ReelsUploadScreen({Key? key, required this.userModel}) : super(key: key);

  @override
  State<ReelsUploadScreen> createState() => _ReelsUploadScreenState();
}

class _ReelsUploadScreenState extends State<ReelsUploadScreen> {
  VideoPlayerController? controller;
  TextEditingController title = TextEditingController();
  File? videoFile;

  bool isLoading = false;

  void pickVideoFile() async {
    final filePickerResult =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (filePickerResult != null) {
      setState(() {
        videoFile = File(filePickerResult.paths[0]!);
        controller = VideoPlayerController.file(videoFile!);
        controller!.initialize();
      });
    }
  }

  void onPostReel() async {
    if (videoFile != null && title.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      // String videoUrl = "";
      String videoId = generateId();
      String videoUrl =
          await ReelsUploadFunction.uploadVideo(videoFile!, videoId) ?? "";
      if (videoUrl.isNotEmpty) {
        ReelsModel reelsModel = ReelsModel(
            uid: widget.userModel.uid,
            id: videoId,
            username: widget.userModel.username,
            profileImage: widget.userModel.profileImage,
            title: title.text,
            videoLink: videoUrl,
            likes: 0);
        await ReelsUploadFunction.postReel(reelsModel);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      print("All Fields are Required");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          "Upload Reel",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? LoadingScreen()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: pickVideoFile,
                    onDoubleTap: () {
                      if (controller != null) {
                        if (controller!.value.isPlaying) {
                          controller!.pause();
                        } else {
                          controller!.play();
                        }
                      }
                    },
                    child: Container(
                      height: 330.h,
                      width: 220.h,
                      color: Colors.grey,
                      child: controller == null
                          ? SizedBox()
                          : VideoPlayer(controller!),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: TextField(
                      controller: title,
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPostReel,
                    child: Text(
                      "Upload Reel",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
