class UserModel {
  String? uid;
  String? name;
  String? username;
  String? email;
  String? bio;
  String? addLink;
  String? profileImage;
  int? posts;
  int? followers;
  int? following;

  UserModel(
      {this.uid,
      this.name,
      this.username,
      this.email,
      this.bio,
      this.addLink,
      this.profileImage,
      this.posts,
      this.followers,
      this.following});

  // class UserModel {
  // late String uid;
  // late String name;
  // late String username;
  // late String bio;
  // late String addLink;
  // late String peofileImage;
  // late int posts;
  // late int followers;
  // late int following;
  //
  // UserModel(
  // {required this.uid,
  // required this.name,
  // required this.username,
  // required this.bio,
  // required this.addLink,
  // required this.profileImage,
  // required this.posts,
  // required this.followers,
  // required this.following});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    bio = json['bio'];
    addLink = json['add_link'];
    profileImage = json['profile_image'];
    posts = json['posts'];
    followers = json['followers'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['add_link'] = this.addLink;
    data['profile_image'] = this.profileImage;
    data['posts'] = this.posts;
    data['followers'] = this.followers;
    data['following'] = this.following;
    return data;
  }
}
