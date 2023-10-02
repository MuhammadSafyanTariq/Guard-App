import 'package:flutter/material.dart';
import 'package:guard/Employer/Forms/JobForm.dart';
import 'package:guard/users/Screens/MyInvitations.dart/Filter.dart';
import 'package:guard/users/Screens/Search/AllJobs.dart';
import 'package:guard/users/Screens/Search/MainSearchScreen.dart';
import '../../Employer/Screen/EmployeJob.dart';
import 'profile/Profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    Profile(),
    AllJobsScreen(),
    InvitaionFilter(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.black, // Set selected color to red
          unselectedItemColor: Colors.grey,
          iconSize: 40, // Set unselected color to black
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Find Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'My Jobs',
            ),
          ],
        ),
      ),
    );
  }
}
