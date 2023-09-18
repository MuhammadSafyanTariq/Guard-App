import 'package:flutter/material.dart';
import 'Invite.dart';
import 'JobList.dart';
import 'MyJobs.dart';
import 'Profile.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
              label: 'My Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
        ),
      ),
    );
  }
}
