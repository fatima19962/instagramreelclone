class ReelsModel {
  late String? uid;
  late String? id;
  late String? username;
  late String? profileImage;
  late String? title;
  late String? videoLink;
  late int? likes;

  ReelsModel({required this.uid,
    required this.id,
    required this.username,
    required this.profileImage,
    required this.title,
    required this.videoLink,
    required this.likes});

  ReelsModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    id = json['id'];
    username = json['username'];
    profileImage = json['profile_image'];
    title = json['title'];
    videoLink = json['video_link'];
    likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['id'] = this.id;
    data['username'] = this.username;
    data['profile_image'] = this.profileImage;
    data['title'] = this.title;
    data['video_link'] = this.videoLink;
    data['likes'] = this.likes;
    return data;
  }
}
