import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guard/users/Screens/LoginScreen.dart';
import 'package:guard/users/Screens/SingleJobCardEmploye.dart';

class MatchedJobsScreen extends StatefulWidget {
  @override
  State<MatchedJobsScreen> createState() => _MatchedJobsScreenState();
}

class _MatchedJobsScreenState extends State<MatchedJobsScreen> {
  List<dynamic> badgeType = [''];
  String city = '';

  var userData = {};
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        badgeType = userData['BadgeType'];
        city = userData['City'];
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Position? _currentPosition; // Store the user's current position

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Get the user's current location when the widget initializes
    getData().then((_) {
      setState(() {});
    });
  }

  // Function to get the user's current location
  void _getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print('Error obtaining location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // getData();
    print('type                     $city');
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search JOBS"),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(6),
            constraints: BoxConstraints(
              minWidth: W * 0.95,
              maxWidth: W * 0.95,
              minHeight: H * 0.8,
              maxHeight: H * 0.8,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  (20),
                ),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black,
                    blurRadius: 20,
                    spreadRadius: 2.0,
                    offset: Offset(-10, 7)),
              ],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.grey,
                  const Color.fromARGB(255, 124, 123, 123)
                ],
              ),
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('job')
                  .where('jobBadge', whereIn: badgeType)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                // ignore: unrelated_type_equality_checks
                if (ConnectionState == ConnectionState.waiting ||
                    snapshot.data == null ||
                    _currentPosition == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final double radiusInDegrees = 50 / 111.32;
                final double userLat = _currentPosition!.latitude;
                final double userLon = _currentPosition!.longitude;
                // final double userLat = 32.437873;
                // final double userLon = 74.115622;
                print('My lat                   $userLat           $userLon');
                final double maxLat = userLat + radiusInDegrees;
                final double minLat = userLat - radiusInDegrees;
                final double maxLon = userLon + radiusInDegrees;
                final double minLon = userLon - radiusInDegrees;

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final jobData = snapshot.data!.docs[index].data();
                    final jobLat = jobData['latitude'];
                    final jobLon = jobData['longitude'];

                    if (jobLat <= maxLat &&
                        jobLat >= minLat &&
                        jobLon <= maxLon &&
                        jobLon >= minLon) {
                      return SingleJobCardEmploye(snap: jobData);
                    } else {
                      return SizedBox();
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
