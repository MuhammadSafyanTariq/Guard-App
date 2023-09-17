import 'package:flutter/material.dart';
import 'package:guard/user/Resource/Auth_Methods.dart';
import 'package:guard/user/Screens/MainPage.dart';
import 'package:guard/user/utils/utils.dart';
import 'package:uuid/uuid.dart';

class GuardForm extends StatefulWidget {
  @override
  _GuardFormState createState() => _GuardFormState();
}

class _GuardFormState extends State<GuardForm> {
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  Future<String> SignUpUser() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    res = await _authMethods.signUpUser(
        FullName: _fullName!,
        email: _email!,
        password: _passwordController.text,
        phone: _phoneNumber!,
        BadgeType: _selectedBadgeTypes,
        DrivingLicence: _selectedDrivingLicense!,
        City: _selectedRadius!,
        Shift: _selectedShiftPreferences);
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
  String? _selectedRadius;
  List<String> _selectedShiftPreferences = [];
  String? _fullName;
  String? _email;
  String? _phoneNumber;
  final _passwordController = TextEditingController();
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

  Widget buildCityDropdown() {
    List<DropdownMenuItem<String>> items = cities.map((city) {
      return DropdownMenuItem<String>(value: city, child: Text(city));
    }).toList();

    return DropdownButtonFormField<String>(
      value: _selectedRadius,
      onChanged: (value) {
        setState(() {
          _selectedRadius = value;
        });
      },
      items: items,
      decoration: InputDecoration(labelText: 'Select City'),
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
      body: SingleChildScrollView(
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
                  SignUpUser();
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
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
        title: Text('City'),
        content: Column(
          children: [
            buildCityDropdown(),
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
