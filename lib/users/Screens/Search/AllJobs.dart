import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:guard/Employer/Forms/FilterForm.dart';
import 'package:guard/users/Forms/FilterForm.dart';
import 'package:guard/users/Screens/LoginScreen.dart';
import 'package:guard/users/Screens/Search/FilteredJobs.dart';
import 'package:guard/users/Screens/Search/Nationwide/FilterFormNW.dart';
import 'package:guard/users/Screens/SingleJobCardEmploye.dart';
import 'package:permission_handler/permission_handler.dart';

class AllJobsScreen extends StatefulWidget {
  @override
  State<AllJobsScreen> createState() => _AllJobsScreenState();
}

class _AllJobsScreenState extends State<AllJobsScreen> {
  var userData = {};
  void showFilterFom(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Set to true for a full-height bottom sheet
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // Set to 70% of the screen height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: FilterFormJobs(),
              ),
            ],
          ),
        );
      },
    );
  }

  void showFilterFomNW(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true, // Set to true for a full-height bottom sheet
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8, // Set to 70% of the screen height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: FilterFormJobsNW(),
              ),
            ],
          ),
        );
      },
    );
  }

  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(userSnap);

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        type = userData['type'];
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  initState() {
    super.initState();
    getData().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(type);
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Find JOBS"),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      showFilterFomNW(context);
                    },
                    child: Text(
                      'Filter Nationwide',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final status = await Permission.location.request();
                      if (status.isGranted) showFilterFom(context);
                    },
                    icon: Icon(
                      FontAwesomeIcons.sliders,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
                    // .where()
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (ConnectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => SingleJobCardEmploye(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
