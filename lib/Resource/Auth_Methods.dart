import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:guard/Models/Guard.dart';
import 'package:guard/Resource/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<GuardModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return GuardModel.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String FullName,
    required String email,
    required String password,
    required String phone,
    required List<String> BadgeType,
    required String DrivingLicence,
    required String City,
    required List<String> Shift,
  }) async {
    String res = "Some error Occurred";
    try {
      if (FullName.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          phone.isNotEmpty ||
          BadgeType.isNotEmpty ||
          DrivingLicence.isNotEmpty ||
          Shift.isNotEmpty ||
          City.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // String photoUrl = await StorageMehtods()
        //     .uploadImagetoStorage('profilePics', file, false);

        GuardModel _user = GuardModel(
          FullName: FullName,
          uid: cred.user!.uid,
          email: email,
          phone: phone,
          BadgeType: BadgeType,
          DrivingLicence: DrivingLicence,
          City: City,
          Shift: Shift,
        );

        // adding user in our database
        await _firestore
            .collection("guard")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
