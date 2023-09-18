import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:guard/admin/Models/Employer.dart';
import 'package:guard/Employer/Models/Job.dart';
import 'package:uuid/uuid.dart';

class JobMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> postJob({
    required String title,
    required String description,
    required String email,
    required String city,
    required String benefits, // Add the new fields here
    required String correspondingPerson,
    required String jobType,
    required String location,
    required String position,
    required String rate,
    required String rateType,
    required String shift,
    required String venue,
  }) async {
    String res = "Some error Occurred";
    try {
      if (title.isNotEmpty ||
          email.isNotEmpty ||
          description.isNotEmpty ||
          city.isNotEmpty) {
        String jid = Uuid().v1();

        JobModel jobModel = JobModel(
          jid: jid,
          title: title,
          description: description,
          eid: _auth.currentUser!.uid,
          empContactEmail: email,
          city: city,
          benefits: benefits, // Assign the new fields here
          correspondingPerson: correspondingPerson,
          jobType: jobType,
          location: location,
          position: position,
          rate: rate,
          rateType: rateType,
          shift: shift,
          venue: venue,
        );

        // adding user in our database
        await _firestore.collection("job").doc(jid).set(jobModel.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> deleteJob(String jid) async {
    try {
      await _firestore.collection('job').doc(jid).delete();
    } catch (error) {
      print(error.toString());
    }
  }
}
