import 'package:cloud_firestore/cloud_firestore.dart';

class GuardModel {
  final String FullName;
  final String uid;
  final String email;
  final String phone;
  final List<String> BadgeType;
  final String DrivingLicence;
  final String City;
  final List<String> Shift;

  const GuardModel({
    required this.FullName,
    required this.uid,
    required this.email,
    required this.phone,
    required this.BadgeType,
    required this.DrivingLicence,
    required this.City,
    required this.Shift,
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
      };
}
