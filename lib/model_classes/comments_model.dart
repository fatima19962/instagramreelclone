class CommentsModel {
  late String id;
  late String uid;
  late String username;
  late String profileImage;
  late String comment;

  CommentsModel({
    required this.id,
    required this.uid,
    required this.username,
    required this.profileImage,
    required this.comment});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    username = json['username'];
    profileImage = json['profile_image'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['profile_image'] = this.profileImage;
    data['comment'] = this.comment;
    return data;
  }
}
