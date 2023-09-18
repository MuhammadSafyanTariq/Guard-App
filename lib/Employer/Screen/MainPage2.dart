import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/MyJobs.dart';
import '../../users/Screens/Invite.dart';
import '../../users/Screens/JobList.dart';
import '../../users/Screens/Profile.dart';

class MainPage2 extends StatefulWidget {
  @override
  _MainPage2State createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    Profile(),
    Dash(),
    MyJobs(),
    Invite(),
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
              icon: Icon(Icons.dashboard),
              label: 'Dash',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'My Ads',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Invite',
            ),
          ],
        ),
      ),
    );
  }
}