import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/admin/utils/utils.dart';
import 'package:guard/users/Models/Guard.dart';
import 'package:guard/users/Screens/profile/EditGaurdForm.dart';

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
    required String Shift,
    required String postCode,
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
          City.isNotEmpty ||
          postCode.isNotEmpty) {
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
          type: 'employee',
          postCode: postCode,
          address2: '',
          dateOfBirth: '',
          gender: '',
          photoUrl: '',
          police: false,
        );

        // adding user in our database
        await _firestore
            .collection("users")
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

  Future<String> resetPassword(String email) async {
    String res = '';
    try {
      if (email.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        res = 'success';
      } else {
        res = 'Enter Email';
      }
      print('Password reset email sent to $email');
    } catch (e) {
      res = e.toString();
      print('Error sending password reset email: $e');
      throw e; // You can handle the error as needed, e.g., show an error message to the user.
    }
    return res;
  }

  Future<String> editGuard({
    required String FullName,
    required String phone,
    required List<String> BadgeType,
    required String DrivingLicence,
    required String City,
    required String Shift,
    required String postCode,
    required String dateOfBirth,
    required String address2,
    required String gender,
    required bool police,
    required String photoUrl,
  }) async {
    String res = "Some error Occurred";
    try {
      if (FullName.isNotEmpty ||
          phone.isNotEmpty ||
          BadgeType.isNotEmpty ||
          DrivingLicence.isNotEmpty ||
          Shift.isNotEmpty ||
          City.isNotEmpty) {
        GuardModel _user = GuardModel(
          FullName: FullName,
          uid: FirebaseAuth.instance.currentUser!.email.toString(),
          email: _auth.currentUser!.email.toString(),
          phone: phone,
          BadgeType: BadgeType,
          DrivingLicence: DrivingLicence,
          City: City,
          Shift: Shift,
          type: 'Guard',
          address2: address2,
          dateOfBirth: dateOfBirth,
          gender: gender,
          photoUrl: photoUrl,
          police: police,
          postCode: postCode,
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
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
}
