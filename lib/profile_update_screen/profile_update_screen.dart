import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramreelclone/const.dart';
import 'package:instagramreelclone/loading_screen/loading_screen.dart';
import 'package:instagramreelclone/model_classes/user_model.dart';
import 'package:instagramreelclone/profile_update_screen/profile_update_function.dart';

class ProfileUpdateScreen extends StatefulWidget {
  final UserModel userModel;

  const ProfileUpdateScreen({Key? key, required this.userModel})
      : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController biocontroller = TextEditingController();
  final TextEditingController addLinkcontroller = TextEditingController();
  File? profileImage;
  bool isLoading = false;

  void pickImage() async {
    final pickedImage =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onSavingDetails();
  }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   namecontroller.dispose();
  //   usernamecontroller.dispose();
  //   biocontroller.dispose();
  //   addLinkcontroller.dispose();
  //   super.dispose();
  // }

  void onSavingDetails() async {
    if (namecontroller.text.isNotEmpty && usernamecontroller.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      String profileImageUrl = "";
      if (profileImage != null) {
        String imageId = generateId();
        profileImageUrl =
            await ProfileUpdateFunction.uploadImage(profileImage!, imageId) ??
                "";
      }
      Map<String, dynamic> userDetails = {
        // "uid":"",
        "name": namecontroller.text,
        "username": usernamecontroller.text,
        "bio": biocontroller.text,
        "add_link": addLinkcontroller.text,
        "profile_image": profileImageUrl.isNotEmpty
            ? profileImageUrl
            : widget.userModel.profileImage,
      };
      await ProfileUpdateFunction.updateUserProfile(userDetails);
      setState(() {
        isLoading = false;
      });
    } else {
      print("Username & name are required");
    }
  }

  //
  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   setUserDetails();
  // }

  void setUserDetails() {
    namecontroller.text = widget.userModel.name!;
    usernamecontroller.text = widget.userModel.username!;
    biocontroller.text = widget.userModel.bio!;
    addLinkcontroller.text = widget.userModel.addLink!;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Edit Profile",
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: onSavingDetails,
                  icon: Icon(Icons.done, color: Colors.blue),
                )
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      height: 90.h,
                      width: 90.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                          image: profileImage != null
                              ? FileImage(profileImage!) as ImageProvider
                              : NetworkImage(widget.userModel.profileImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // child: Icon(Icons.account_circle,size: 90.sp,),
                    ),
                    TextButton(
                      onPressed: pickImage,
                      child: Text(
                        "Change profile photo",
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                    // customTextField("Name", namecontroller),
                    // customTextField("Username", usernamecontroller),
                    // customTextField("Bio", biocontroller),
                    // customTextField("Add link", addLinkcontroller),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                            labelText: "Name",
                            isDense: true,
                            // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: OutlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextFormField(
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                            // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                            labelText: "Username",
                            isDense: true,
                            // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: OutlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextFormField(
                          controller: biocontroller,
                          decoration: InputDecoration(
                            // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                            labelText: "Bio",
                            isDense: true,
                            // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: OutlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextFormField(
                          controller: addLinkcontroller,
                          decoration: InputDecoration(
                            // hintStyle: TextStyle(letterSpacing: 2, color: Colors.black54, fontWeight: FontWeight.bold),
                            labelText: "Add link",
                            isDense: true,
                            // contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            border: OutlineInputBorder(),
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget customTextField(String hintText, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: TextField(
        // controller: namecontroller,
        // controller: usernamecontroller,
        // controller: biocontroller,
        // controller: addLinkcontroller,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    );
  }
}
