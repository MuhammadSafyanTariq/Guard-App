import 'package:cloud_firestore/cloud_firestore.dart';

class GuardModel {
  final String FullName;
  final String uid;
  final String email;
  final String phone;
  final List<String> BadgeType;
  final String DrivingLicence;
  final String City;
  final String Shift;
  final String type;
  final List<String> appliedForJobs = [];
  final String postCode;
  final String? dateOfBirth;
  final String? address2;
  final String gender;
  final bool police;
  final String? photoUrl;

  GuardModel({
    required this.FullName,
    required this.uid,
    required this.email,
    required this.phone,
    required this.BadgeType,
    required this.DrivingLicence,
    required this.City,
    required this.Shift,
    required this.type,
    required this.postCode,
    required this.dateOfBirth,
    required this.address2,
    required this.gender,
    required this.police,
    required this.photoUrl,
  });

  static GuardModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String?, dynamic>;

    return GuardModel(
      FullName: snapshot["FullName"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      phone: snapshot["phone"],
      BadgeType: snapshot["BadgeType"],
      DrivingLicence: snapshot["DrivingLicence"],
      City: snapshot["City"],
      Shift: snapshot["Shift"],
      type: snapshot['type'],
      gender: snapshot['gender'],
      address2: snapshot['address2'],
      dateOfBirth: snapshot['dateOfBirth'],
      photoUrl: snapshot['photoUrl'],
      police: snapshot['police'],
      postCode: snapshot['postCode'],
    );
  }

  Map<String, dynamic> toJson() => {
        "FullName": FullName,
        "uid": uid,
        "email": email,
        "phone": phone,
        "BadgeType": BadgeType,
        "DrivingLicence": DrivingLicence,
        "City": City,
        "Shift": Shift,
        "type": "Guard",
        "appliedForJobs": appliedForJobs,
      };
}
