class UserModel {
  late String studentName;
  late String image;
  late String parentPhone;
  late String studentPhone;
  late String center;
  late String uid;
  late String level;
  late String email;
  late bool accepted;
  late bool admin;
  late bool open;

  UserModel({
    required this.uid,
    required this.email,
    required this.studentName,
    required this.image,
    required this.parentPhone,
    required this.studentPhone,
    required this.level,
    required this.center,
    required this.accepted,
    required this.admin,
    required this.open,
  });

  UserModel.fromjson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    image = json['image'];
    studentName = json['studentName'];
    parentPhone = json['parentPhone'];
    studentPhone = json['studentPhone'];
    center = json['center'];
    accepted = json['accepted'];
    level = json['level'];
    admin = json['admin'];
    open = json['open'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'studentName': studentName,
      'image': image,
      'parentPhone': parentPhone,
      'studentPhone': studentPhone,
      'center': center,
      'level': level,
      'accepted': accepted,
      'admin': admin,
      'open': open,
    };
  }
}
