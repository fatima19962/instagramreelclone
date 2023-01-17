import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagramreelclone/comment_screen/comment_screen_function.dart';


import 'package:instagramreelclone/const.dart';import 'package:instagramreelclone/loading_screen/loading_screen.dart';import 'package:instagramreelclone/model_classes/comments_model.dart';
import 'package:instagramreelclone/profile_screen/profile_screen_ui.dart';
import 'package:instagramreelclone/shared_prefrences/shared_preference.dart';

class CommentScreen extends StatefulWidget {
  final String reelId;

  CommentScreen({Key? key, required this.reelId}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<CommentsModel> commentModel = [];
  final TextEditingController comment = TextEditingController();
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllComments();
  }

  void getAllComments() async {
   commentModel=await CommentFunction.getAllReelComments(widget.reelId) ??[];
   setState(() {
     isLoading=false;
   });
  }
void onPostComment() async{
if(comment.text.isNotEmpty){
  setState(() {
    isLoading=true;
  });
  String uid =await SharedPrefrencesHelper.getString("uid");
  String username =await SharedPrefrencesHelper.getString("username");
  String profileImage =await SharedPrefrencesHelper.getString("profile_image");
  CommentsModel commentsModel = CommentsModel(
      id: generateId(),
      uid: uid,
      username: username,
      profileImage: profileImage,
      comment: comment.text);
  await CommentFunction.postComment(widget.reelId, commentsModel);
  commentModel.add(commentsModel);
  comment.clear();
  setState(() {
    isLoading=false;
  });
}else{
  print("Please Enter something");
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Comments",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body:isLoading?LoadingScreen(): Column(
          children: [
            commentModel.isNotEmpty?   Expanded(
              child: ListView.builder(
                  itemCount: commentModel.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(
                            userUid:commentModel[index].uid,
                        ),
                        ),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(commentModel[index].profileImage),
                      ),
                      title: Text(commentModel[index].username),
                      subtitle: Text(commentModel[index].comment),
                    );
                  }),
            ):Expanded(
              child: Center(
                child: Text(
                  "No Comments Available.",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.sp),
              child: Row(
                children: [
               Expanded(
                    child: TextField(
                      controller: comment,
                      decoration: InputDecoration(
                        hintText: "Comment Here",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(onPressed:onPostComment, icon: Icon(Icons.send)),
                ],
              ),
            ),
          ],
        ));
  }
}
