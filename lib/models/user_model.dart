class UserModel {
  late String studentName;
  late String image;
  late String parentPhone;
  late String studentPhone;
  late String academicYear;
  late String center;
  late String uid;
  late String email;
  late bool accepted;

  UserModel({
    required this.uid,
    required this.email,
    required this.studentName,
    required this.image,
    required this.parentPhone,
    required this.studentPhone,
    required this.academicYear,
    required this.center,
    required this.accepted,
  });

  UserModel.fromjson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    image = json['image'];
    studentName = json['studentName'];
    parentPhone = json['parentPhone'];
    studentPhone = json['studentPhone'];
    academicYear = json['academicYear'];
    center = json['center'];
    accepted = json['accepted'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'studentName': studentName,
      'image': image,
      'parentPhone': parentPhone,
      'studentPhone': studentPhone,
      'academicYear': academicYear,
      'center': center,
      'accepted': accepted,
    };
  }
}
