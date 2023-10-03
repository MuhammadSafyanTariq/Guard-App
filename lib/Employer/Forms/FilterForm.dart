import 'package:flutter/material.dart';
import 'package:guard/Employer/Search/FilteredEmployers.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Screens/MainPage.dart';
import 'package:guard/users/Screens/Search/FilteredJobs.dart';
import 'package:guard/users/utils/utils.dart';
import 'package:uuid/uuid.dart';

class FilterForm extends StatefulWidget {
  @override
  _FilterFormState createState() => _FilterFormState();
}

class _FilterFormState extends State<FilterForm> {
  int _currentStep = 0;

  // For checkboxes and dropdown values
  List<String> _selectedBadgeTypes = [''];
  String _selectedShiftPreferences = 'Day';
  String _selectedDrivingLicense = 'UK Full';

  Widget buildBadgeTypeCheckbox(String title) {
    return CheckboxListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
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

  Widget buildShiftDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedShiftPreferences,
      onChanged: (value) {
        setState(() {
          _selectedShiftPreferences = value!;
        });
      },
      items: [
        DropdownMenuItem(value: 'Day', child: Text('Day')),
        DropdownMenuItem(value: 'Night', child: Text('Night')),
        DropdownMenuItem(value: 'Any', child: Text('Any')),
      ],
      decoration: InputDecoration(labelText: 'Select Shift'),
    );
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
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
            child: Column(
              children: [
                Stepper(
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FilteredEmployesScreen(
                            selectedBadgeTypes: _selectedBadgeTypes,
                            selectedShiftPreferences: _selectedShiftPreferences,
                            selectedDrivingLicense: _selectedDrivingLicense,
                          ),
                        ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDrivingLicenseDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDrivingLicense,
      onChanged: (value) {
        setState(() {
          _selectedDrivingLicense = value!;
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

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text(
          'Badge Type',
          style: TextStyle(color: Colors.black),
        ),
        content: Column(
          children: [
            buildBadgeTypeCheckbox(
              'Security Guard',
            ),
            buildBadgeTypeCheckbox('Door Supervisor'),
            buildBadgeTypeCheckbox('CCTV'),
            buildBadgeTypeCheckbox('Close Protection'),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text(
          'Driving License',
          style: TextStyle(color: Colors.black),
        ),
        content: Column(
          children: [
            buildDrivingLicenseDropdown(),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Shift Preference'),
        content: buildShiftDropdown(),
        isActive: true,
      ),
    ];
  }
}
