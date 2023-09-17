import 'package:flutter/material.dart';
import 'package:guard/Screens/MainPage.dart';

class GuardForm extends StatefulWidget {
  @override
  _GuardFormState createState() => _GuardFormState();
}

class _GuardFormState extends State<GuardForm> {
  int _currentStep = 0;

  // For checkboxes and dropdown values
  List<String> _selectedBadgeTypes = [];
  String? _selectedDrivingLicense;
  String? _selectedRadius;
  List<String> _selectedShiftPreferences = [];

  String? _fullName;
  String? _email;
  String? _phoneNumber;

  Widget buildBadgeTypeCheckbox(String title) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedBadgeTypes.contains(title),
      onChanged: (value) {
        setState(() {
          if (value ?? false) {
            _selectedBadgeTypes.add(title);
          } else {
            _selectedBadgeTypes.remove(title);
          }
        });
      },
    );
  }

  Widget buildDrivingLicenseDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDrivingLicense,
      onChanged: (value) {
        setState(() {
          _selectedDrivingLicense = value;
        });
      },
      items: [
        DropdownMenuItem(value: 'UK Full', child: Text('UK Full')),
        DropdownMenuItem(value: 'UK Automatic', child: Text('UK Automatic')),
        DropdownMenuItem(value: 'EU License', child: Text('EU License')),
        DropdownMenuItem(
            value: 'International License',
            child: Text('International License')),
        DropdownMenuItem(value: 'No License', child: Text('No License')),
      ],
      decoration: InputDecoration(labelText: 'Select Driving License'),
    );
  }

  Widget buildRadiusDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRadius,
      onChanged: (value) {
        setState(() {
          _selectedRadius = value;
        });
      },
      items: [
        DropdownMenuItem(value: '20 miles', child: Text('20 miles')),
        DropdownMenuItem(value: '50 miles', child: Text('50 miles')),
        DropdownMenuItem(value: '100 miles', child: Text('100 miles')),
        DropdownMenuItem(value: '200 miles', child: Text('200 miles')),
        DropdownMenuItem(value: 'Nationwide', child: Text('Nationwide')),
      ],
      decoration: InputDecoration(labelText: 'Select Radius'),
    );
  }

  Widget buildShiftPreferenceCheckbox(String title) {
    return CheckboxListTile(
      title: Text(title),
      value: _selectedShiftPreferences.contains(title),
      onChanged: (value) {
        setState(() {
          if (value ?? false) {
            _selectedShiftPreferences.add(title);
          } else {
            _selectedShiftPreferences.remove(title);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Guard Registration',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stepper(
        steps: _buildSteps(),
        currentStep: _currentStep,
        onStepTapped: (step) {
          setState(() {
            _currentStep = step;
          });
        },
        onStepContinue: () {
          if (_currentStep < _buildSteps().length - 1) {
            setState(() {
              _currentStep++;
            });
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MainPage()), // Replace with the actual route
            );
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
      ),
    );
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('Personal Information'),
        content: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _fullName = value;
                });
              },
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('SIA Badge Type'),
        content: Column(
          children: [
            buildBadgeTypeCheckbox('Security Guard'),
            buildBadgeTypeCheckbox('Door Supervisor'),
            buildBadgeTypeCheckbox('CCTV'),
            buildBadgeTypeCheckbox('Close Protection'),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Driving License'),
        content: Column(
          children: [
            buildDrivingLicenseDropdown(),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Radius of Distance'),
        content: Column(
          children: [
            buildRadiusDropdown(),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Shift Preference'),
        content: Column(
          children: [
            buildShiftPreferenceCheckbox('Day'),
            buildShiftPreferenceCheckbox('Night'),
            buildShiftPreferenceCheckbox('Any'),
          ],
        ),
        isActive: true,
      ),
    ];
  }
}
