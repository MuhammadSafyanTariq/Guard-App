import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String jid;
  final String title;
  final String description;
  final String eid;
  final String empContactEmail;
  final String city;

  const JobModel({
    required this.jid,
    required this.title,
    required this.description,
    required this.eid,
    required this.empContactEmail,
    required this.city,
  });

  static JobModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String?, dynamic>;

    return JobModel(
      jid: snapshot["jid"],
      title: snapshot["title"],
      description: snapshot["description"],
      eid: snapshot["eid"],
      empContactEmail: snapshot["empContactEmail"],
      city: snapshot["city"],
    );
  }

  Map<String, dynamic> toJson() => {
        "jid": jid,
        "title": title,
        "description": description,
        "eid": eid,
        "empContactEmail": empContactEmail,
        "city": city,
      };
}
