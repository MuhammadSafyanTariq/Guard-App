import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String jid;
  final String title;
  final String description;
  final String eid;
  final String empContactEmail;
  final String city;
  final String benefits;
  final String correspondingPerson;
  final String jobType;
  final String location;
  final String position;
  final String rate;
  final String rateType;
  final String shift;
  final String venue;
  final String jobBadge;
  final List<String> candidates = [];
  JobModel({
    required this.jid,
    required this.title,
    required this.description,
    required this.eid,
    required this.empContactEmail,
    required this.city,
    required this.benefits,
    required this.correspondingPerson,
    required this.jobType,
    required this.location,
    required this.position,
    required this.rate,
    required this.rateType,
    required this.shift,
    required this.venue,
    required this.jobBadge,
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
      benefits: snapshot["benefits"],
      correspondingPerson: snapshot["correspondingPerson"],
      jobType: snapshot["jobType"],
      location: snapshot["location"],
      position: snapshot["position"],
      rate: snapshot["rate"],
      rateType: snapshot["rateType"],
      shift: snapshot["shift"],
      venue: snapshot["venue"],
      jobBadge: snapshot["jobBadge"],
    );
  }

  Map<String, dynamic> toJson() => {
        "jid": jid,
        "title": title,
        "description": description,
        "eid": eid,
        "empContactEmail": empContactEmail,
        "city": city,
        "benefits": benefits,
        "correspondingPerson": correspondingPerson,
        "jobType": jobType,
        "location": location,
        "position": position,
        "rate": rate,
        "rateType": rateType,
        "shift": shift,
        "venue": venue,
        "jobBadge": jobBadge,
        "candidates": candidates,
      };
}
