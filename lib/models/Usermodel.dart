class UserModel {
  String? uid;
  String? username;
  String? email;
  String? profilepic;

  UserModel({this.uid, this.username, this.email, this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map){
    uid = map["uid"];
    username = map["name"];
    email = map["email"];
    profilepic = map["photourl"];
  }

  Map<String, dynamic> toMap(){
    return {
      "uid": uid,
      "name": username,
      "email": email,
      "photourl": profilepic,
    };
  }
}