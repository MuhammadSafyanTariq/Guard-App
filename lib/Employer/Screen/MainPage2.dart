import 'package:flutter/material.dart';
import 'package:guard/Employer/Forms/JobForm.dart';
import 'package:guard/Employer/Screen/PostJobs.dart';
import 'package:guard/Employer/Search/MainSearchScreen.dart';
import 'package:guard/chat/homepage.dart';
import '../../users/Screens/MyInvitations.dart/Invite.dart';
import 'EmployeJob.dart';
import '../../users/Screens/profile/Profile.dart';

class MainPage2 extends StatefulWidget {
  @override
  _MainPage2State createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    EmployeeJobs(),
    MainSearchScreen(),
    MyHomePage(),
    Profile(),
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
              icon: Icon(Icons.dashboard),
              label: 'Dash',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
