class UserModel {
  late String studentName;
  late String parentPhone;
  late String studentPhone;
  late String uid;
  late String email;

  UserModel({
    required this.uid,
    required this.email,
    required this.studentName,
    required this.parentPhone,
    required this.studentPhone,
  });

  UserModel.fromjson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    studentName = json['studentName'];
    parentPhone = json['parentPhone'];
    studentPhone = json['studentPhone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'studentName': studentName,
      'parentPhone': parentPhone,
      'studentPhone': studentPhone,
    };
  }
}
