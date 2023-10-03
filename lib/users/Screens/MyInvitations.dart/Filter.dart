import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guard/users/Screens/LoginScreen.dart';
import 'package:guard/users/Screens/MyInvitations.dart/SingleInvitation.dart';
import 'package:guard/users/Screens/SingleJobCardEmploye.dart';

class InvitaionFilter extends StatefulWidget {
  @override
  State<InvitaionFilter> createState() => _InvitaionFilterState();
}

class _InvitaionFilterState extends State<InvitaionFilter> {
  var userData = {};
  List<dynamic>? invitaion;
  getData() async {
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      print(userSnap);

      if (userSnap.exists) {
        userData = userSnap.data() as Map<String, dynamic>;
        invitaion = userData['invitations'];
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
          title: Text("Job invitations"),
          backgroundColor: Colors.black,
        ),
        body: invitaion != null
            ? Center(
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
                          .where('jid', whereIn: invitaion)
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
                          itemBuilder: (context, index) => InvitationCard(
                            snap: snapshot.data!.docs[index].data(),
                          ),
                        );
                      }),
                ),
              )
            : Center(
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
                  child: Text('No invitaions'),
                ),
              ),
      ),
    );
  }
}
