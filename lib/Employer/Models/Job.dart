import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  final String jid;
  final String title;
  final String description;
  final String eid;
  final String empContactEmail;
  final double longitude;
  final double latitude;
  final String benefits;
  final String correspondingPerson;
  final String jobType;
  final String position;
  final String rate;
  final String rateType;
  final String shift;
  final String venue;
  final String jobBadge;
  final String address;
  final List<String> candidates = [];
  JobModel(
      {required this.jid,
      required this.title,
      required this.description,
      required this.eid,
      required this.empContactEmail,
      required this.benefits,
      required this.correspondingPerson,
      required this.jobType,
      required this.position,
      required this.rate,
      required this.rateType,
      required this.shift,
      required this.venue,
      required this.jobBadge,
      required this.longitude,
      required this.latitude,
      required this.address});

  static JobModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String?, dynamic>;

    return JobModel(
        jid: snapshot["jid"],
        title: snapshot["title"],
        description: snapshot["description"],
        eid: snapshot["eid"],
        empContactEmail: snapshot["empContactEmail"],
        benefits: snapshot["benefits"],
        correspondingPerson: snapshot["correspondingPerson"],
        jobType: snapshot["jobType"],
        position: snapshot["position"],
        rate: snapshot["rate"],
        rateType: snapshot["rateType"],
        shift: snapshot["shift"],
        venue: snapshot["venue"],
        jobBadge: snapshot["jobBadge"],
        longitude: snapshot["longitude"],
        latitude: snapshot["latitude"],
        address: snapshot['address']);
  }

  Map<String, dynamic> toJson() => {
        "jid": jid,
        "title": title,
        "description": description,
        "eid": eid,
        "empContactEmail": empContactEmail,
        "benefits": benefits,
        "correspondingPerson": correspondingPerson,
        "jobType": jobType,
        "position": position,
        "rate": rate,
        "rateType": rateType,
        "shift": shift,
        "venue": venue,
        "jobBadge": jobBadge,
        "candidates": candidates,
        "longitude": longitude,
        "latitude": latitude,
        'address': address,
      };
}
