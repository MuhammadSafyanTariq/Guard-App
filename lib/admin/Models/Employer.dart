import 'package:cloud_firestore/cloud_firestore.dart';

class EmployerModel {
  final String companyName;
  final String uid;
  final String email;
  final String phone;
  final String correspondingPerson;
  final String address;

  const EmployerModel({
    required this.companyName,
    required this.uid,
    required this.email,
    required this.phone,
    required this.correspondingPerson,
    required this.address,
  });

  static EmployerModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String?, dynamic>;

    return EmployerModel(
      companyName: snapshot["CompanyName"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      phone: snapshot["phone"],
      correspondingPerson: snapshot["CorrespondingPerson"],
      address: snapshot["address"],
    );
  }

  Map<String, dynamic> toJson() => {
        "CompanyName": companyName,
        "uid": uid,
        "email": email,
        "phone": phone,
        "CorrespondingPerson": correspondingPerson,
        "address": address,
        "type": "employer",
      };
}
