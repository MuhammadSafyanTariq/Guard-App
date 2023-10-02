import 'package:flutter/material.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Screens/MainPage.dart';
import 'package:guard/users/utils/utils.dart';
import 'package:uuid/uuid.dart';

class EditGuardForm extends StatefulWidget {
  @override
  _EditGuardFormState createState() => _EditGuardFormState();
}

class _EditGuardFormState extends State<EditGuardForm> {
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  Future<String> editGuard() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    res = await _authMethods.editGuard(
      FullName: _fullName!,
      phone: _phoneNumber!,
      BadgeType: _selectedBadgeTypes,
      DrivingLicence: _selectedDrivingLicense!,
      City: address!,
      Shift: _selectedShiftPreferences!,
    );
    // setState(() {
    //   _isLoading = false;
    // });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }
    return res;
  }

  int _currentStep = 0;

  // For checkboxes and dropdown values
  List<String> _selectedBadgeTypes = [];
  String? _selectedDrivingLicense;
  String? address;
  String _selectedShiftPreferences = 'Day';
  String? _fullName;
  String? _phoneNumber;
  List<String> cities = [
    'Belfast',
    'Birmingham',
    'Bradford',
    'Brighton and Hove',
    'Bristol',
    'Cambridge',
    'Cardiff',
    'Coventry',
    'Derby',
    'Edinburgh',
    'Glasgow',
    'Leeds',
    'Leicester',
    'Liverpool',
    'London',
    'Manchester',
    'Newcastle upon Tyne',
    'Nottingham',
    'Oxford',
    'Plymouth',
    'Portsmouth',
    'Sheffield',
    'Southampton',
    'Stoke-on-Trent',
    'Sunderland',
    'Swansea',
    'Wakefield',
    'Wolverhampton',
    'York'
  ];

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

  Widget buildCityDropdown() {
    List<DropdownMenuItem<String>> items = cities.map((city) {
      return DropdownMenuItem<String>(value: city, child: Text(city));
    }).toList();

    return DropdownButtonFormField<String>(
      value: address,
      onChanged: (value) {
        setState(() {
          address = value;
        });
      },
      items: items,
      decoration: InputDecoration(labelText: 'Select City'),
    );
  }

  // Widget buildShiftPreferenceCheckbox(String title) {
  //   return CheckboxListTile(
  //     title: Text(title),
  //     value: _selectedShiftPreferences.contains(title),
  //     onChanged: (value) {
  //       setState(() {
  //         if (value ?? false) {
  //           _selectedShiftPreferences.add(title);
  //         } else {
  //           _selectedShiftPreferences.remove(title);
  //         }
  //       });
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Guard Registration',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
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
          child: SingleChildScrollView(
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
                      editGuard();
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

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text(
          'Personal Information',
          style: TextStyle(color: Colors.black),
        ),
        content: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _fullName = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text(
          'SIA Badge Type',
        ),
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
        title: Text('City'),
        content: TextField(
          onChanged: (value) {
            setState(() {
              address = value;
            });
          },
          decoration: InputDecoration(
            labelText: 'Address',
            labelStyle: TextStyle(color: Colors.white),
          ),
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
