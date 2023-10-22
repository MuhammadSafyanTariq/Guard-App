// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:guard/users/Resource/Auth_Methods.dart';
// import 'package:guard/users/Screens/MainPage.dart';
// import 'package:guard/users/utils/utils.dart';
// import 'package:uuid/uuid.dart';

// class GuardForm extends StatefulWidget {
//   @override
//   _GuardFormState createState() => _GuardFormState();
// }

// class _GuardFormState extends State<GuardForm> {
//   bool _isLoading = false;
//   final AuthMethods _authMethods = AuthMethods();

//   Future<String> SignUpUser() async {
//     String res = '';
//     String postCode = '';
//     setState(() {
//       _isLoading = true;
//     });
//     if (_fullName == null ||
//         _email == null ||
//         _passwordController.text.isEmpty ||
//         _phoneNumber == null ||
//         address == null) {
//       showSnackBar('Enter all data', context);
//     } else {
//       res = await _authMethods.signUpUser(
//         FullName: _fullName!,
//         email: _email!,
//         password: _passwordController.text,
//         phone: _phoneNumber!,
//         BadgeType: _selectedBadgeTypes,
//         DrivingLicence: _selectedDrivingLicense!,
//         City: address!,
//         Shift: _selectedShiftPreferences!,
//         postCode: postCode,
//       );
//       // setState(() {
//       //   _isLoading = false;
//       // });
//       if (res != 'success') {
//         showSnackBar(res, context);
//       } else {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => MainPage(),
//           ),
//         );
//       }
//     }
//     return res;
//   }

//   int _currentStep = 0;
//   final _postalCodeController = TextEditingController();
//   final _houseNumberController = TextEditingController();

//   final _addressController = TextEditingController();

//   String getFormattedAddress() {
//     return _addressController.text;
//   }

//   Future<void> _getAddressFromPostalCode(String postalCode) async {
//     try {
//       List<Location> locations = await locationFromAddress(postalCode);
//       if (locations.isNotEmpty) {
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//           locations.first.latitude,
//           locations.first.longitude,
//         );
//         Placemark placemark = placemarks.first;
//         setState(() {
//           _addressController.text =
//               '${_houseNumberController.text}, ${placemark.thoroughfare},  ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}';
//         });
//       } else {
//         setState(() {
//           _addressController.text = 'No address found for $postalCode';
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _addressController.text = 'Error: ${e.toString()}';
//       });
//     }
//   }

//   // For checkboxes and dropdown values
//   List<String> _selectedBadgeTypes = [];
//   String? _selectedDrivingLicense;
//   String? address;
//   String _selectedShiftPreferences = 'Day';
//   String? _fullName;
//   String? _email;
//   String? _phoneNumber;
//   final _passwordController = TextEditingController();

//   List<String> cities = [
//     'Belfast',
//     'Birmingham',
//     'Bradford',
//     'Brighton and Hove',
//     'Bristol',
//     'Cambridge',
//     'Cardiff',
//     'Coventry',
//     'Derby',
//     'Edinburgh',
//     'Glasgow',
//     'Leeds',
//     'Leicester',
//     'Liverpool',
//     'London',
//     'Manchester',
//     'Newcastle upon Tyne',
//     'Nottingham',
//     'Oxford',
//     'Plymouth',
//     'Portsmouth',
//     'Sheffield',
//     'Southampton',
//     'Stoke-on-Trent',
//     'Sunderland',
//     'Swansea',
//     'Wakefield',
//     'Wolverhampton',
//     'York'
//   ];

//   Widget buildBadgeTypeCheckbox(String title) {
//     return CheckboxListTile(
//       title: Text(title),
//       value: _selectedBadgeTypes.contains(title),
//       onChanged: (value) {
//         setState(() {
//           if (value ?? false) {
//             _selectedBadgeTypes.add(title);
//           } else {
//             _selectedBadgeTypes.remove(title);
//           }
//         });
//       },
//     );
//   }

//   Widget buildDrivingLicenseDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedDrivingLicense,
//       onChanged: (value) {
//         setState(() {
//           _selectedDrivingLicense = value;
//         });
//       },
//       items: [
//         DropdownMenuItem(value: 'UK Full', child: Text('UK Full')),
//         DropdownMenuItem(value: 'UK Automatic', child: Text('UK Automatic')),
//         DropdownMenuItem(value: 'EU License', child: Text('EU License')),
//         DropdownMenuItem(
//             value: 'International License',
//             child: Text('International License')),
//         DropdownMenuItem(value: 'No License', child: Text('No License')),
//       ],
//       decoration: InputDecoration(labelText: 'Select Driving License'),
//     );
//   }

//   Widget buildShiftDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedShiftPreferences,
//       onChanged: (value) {
//         setState(() {
//           _selectedShiftPreferences = value!;
//         });
//       },
//       items: [
//         DropdownMenuItem(value: 'Day', child: Text('Day')),
//         DropdownMenuItem(value: 'Night', child: Text('Night')),
//         DropdownMenuItem(value: 'Any', child: Text('Any')),
//       ],
//       decoration: InputDecoration(labelText: 'Select Shift'),
//     );
//   }

//   Widget buildCityDropdown() {
//     List<DropdownMenuItem<String>> items = cities.map((city) {
//       return DropdownMenuItem<String>(value: city, child: Text(city));
//     }).toList();

//     return DropdownButtonFormField<String>(
//       value: address,
//       onChanged: (value) {
//         setState(() {
//           address = value;
//         });
//       },
//       items: items,
//       decoration: InputDecoration(labelText: 'Select City'),
//     );
//   }

//   Future<String?> getAddressFromPostalCode(String postalCode) async {
//     try {
//       final query = postalCode; // Postal code you want to look up
//       List<Location> locations = await locationFromAddress(query);

//       if (locations.isNotEmpty) {
//         final location = locations.first;
//         final placemarks = await placemarkFromCoordinates(
//             location.latitude, location.longitude);

//         if (placemarks.isNotEmpty) {
//           final placemark = placemarks.first;
//           // You can access various address details from the placemark object.
//           final address = placemark.street.toString();
//           return address;
//         }
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//     return null;
//   }

//   // Widget buildShiftPreferenceCheckbox(String title) {
//   //   return CheckboxListTile(
//   //     title: Text(title),
//   //     value: _selectedShiftPreferences.contains(title),
//   //     onChanged: (value) {
//   //       setState(() {
//   //         if (value ?? false) {
//   //           _selectedShiftPreferences.add(title);
//   //         } else {
//   //           _selectedShiftPreferences.remove(title);
//   //         }
//   //       });
//   //     },
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     double W = MediaQuery.of(context).size.width;
//     double H = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Guard Registration',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           constraints: BoxConstraints(
//             minWidth: W * 0.95,
//             maxWidth: W * 0.95,
//             minHeight: H * 0.8,
//             maxHeight: H * 0.8,
//           ),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(
//               color: Colors.black,
//               width: 2,
//               style: BorderStyle.solid,
//             ),
//             borderRadius: BorderRadius.all(
//               Radius.circular(
//                 (20),
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black,
//                   blurRadius: 20,
//                   spreadRadius: 2.0,
//                   offset: Offset(-10, 7)),
//             ],
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.white,
//                 Colors.grey,
//                 const Color.fromARGB(255, 124, 123, 123)
//               ],
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Stepper(
//                   steps: _buildSteps(),
//                   currentStep: _currentStep,
//                   onStepTapped: (step) {
//                     setState(() {
//                       _currentStep = step;
//                     });
//                   },
//                   onStepContinue: () {
//                     if (_currentStep < _buildSteps().length - 1) {
//                       setState(() {
//                         _currentStep++;
//                       });
//                     } else {
//                       SignUpUser();
//                     }
//                   },
//                   onStepCancel: () {
//                     if (_currentStep > 0) {
//                       setState(() {
//                         _currentStep--;
//                       });
//                     }
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   List<Step> _buildSteps() {
//     return [
//       Step(
//         title: Text(
//           'Personal Information',
//           style: TextStyle(color: Colors.black),
//         ),
//         content: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _fullName = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Full Name',
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _email = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _phoneNumber = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//             TextField(
//               onChanged: (value) {
//                 setState(() {
//                   _passwordController.text = value;
//                 });
//               },
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//         isActive: true,
//       ),
//       Step(
//         title: Text(
//           'SIA Badge Type',
//         ),
//         content: Column(
//           children: [
//             buildBadgeTypeCheckbox('Security Guard'),
//             buildBadgeTypeCheckbox('Door Supervisor'),
//             buildBadgeTypeCheckbox('CCTV'),
//             buildBadgeTypeCheckbox('Close Protection'),
//           ],
//         ),
//         isActive: true,
//       ),
//       Step(
//         title: Text('Driving License'),
//         content: Column(
//           children: [
//             buildDrivingLicenseDropdown(),
//           ],
//         ),
//         isActive: true,
//       ),
//       Step(
//         title: Text('Address'),
//         content: Column(
//           children: [
//             // Column(
//             //   children: <Widget>[
//             //     TextField(
//             //       controller: _postalCodeController,
//             //       decoration: InputDecoration(
//             //         labelText: 'Postal Code',
//             //         errorText: _errorText,
//             //       ),
//             //     ),
//             //     ElevatedButton(
//             //       onPressed: () async {
//             //         final postalCode = _postalCodeController.text;
//             //         if (postalCode.isNotEmpty) {
//             //           address = await getfro(postalCode);
//             //           setState(() {});
//             //           print('aaaaaaaaaaaaaaaaaaaa$address');
//             //         } else {
//             //           setState(() {
//             //             _errorText = 'Postal code cannot be empty';
//             //             _address = null;
//             //           });
//             //         }
//             //       },
//             //       child: Text('Get Address'),
//             //     ),
//             //     if (_address != null)
//             //       Text(
//             //         'Address: $_address',
//             //         style: TextStyle(fontSize: 16),
//             //       ),
//             //   ],
//             // ),
//             Column(
//               children: [
//                 TextFormField(
//                   controller: _postalCodeController,
//                   decoration: InputDecoration(
//                     labelText: 'Postal Code',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextFormField(
//                   controller: _houseNumberController,
//                   decoration: InputDecoration(
//                     labelText: 'House number',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 // CityFormPostalcode(),
//                 ElevatedButton(
//                   onPressed: () {
//                     _getAddressFromPostalCode(_postalCodeController.text);
//                   },
//                   child: Text('Get Address'),
//                 ),
//               ],
//             ),
//             TextField(
//               controller: _addressController,
//               onChanged: (value) {
//                 setState(() {
//                   _addressController.text = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Address',
//                 labelStyle: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//         isActive: true,
//       ),
//       Step(
//         title: Text('Shift Preference'),
//         content: buildShiftDropdown(),
//         isActive: true,
//       ),
//     ];
//   }
// }
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Screens/MainPage.dart';
import 'package:guard/users/utils/utils.dart';

class GuardForm extends StatefulWidget {
  const GuardForm({super.key});

  @override
  _GuardFormState createState() => _GuardFormState();
}

class _GuardFormState extends State<GuardForm> {
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();
  int _currentStep = 0;

  final _postalCodeController = TextEditingController();
  final _houseNumberController = TextEditingController();
  final _addressController = TextEditingController();

  String? _fullName;
  String? _email;
  String? _phoneNumber;
  final _passwordController = TextEditingController();
  final List<String> _selectedBadgeTypes = [];
  String? _selectedDrivingLicense;
  String? address;
  String _selectedShiftPreferences = 'Day';
  Future<String> SignUpUser() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    if (_fullName == null ||
        _email == null ||
        _passwordController.text.isEmpty ||
        _phoneNumber == null ||
        _addressController.text.isEmpty) {
      showSnackBar('Enter all data', context);
    } else {
      res = await _authMethods.signUpUser(
        FullName: _fullName!,
        email: _email!,
        password: _passwordController.text,
        phone: _phoneNumber!,
        BadgeType: _selectedBadgeTypes,
        DrivingLicence: _selectedDrivingLicense!,
        City: _addressController.text,
        Shift: _selectedShiftPreferences,
        postCode: _postalCodeController.text,
      );
      setState(() {
        _isLoading = false;
      });
      if (res != 'success') {
        showSnackBar(res, context);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainPage(),
          ),
        );
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Guard Registration',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.95,
                  maxWidth: MediaQuery.of(context).size.width * 0.95,
                  minHeight: MediaQuery.of(context).size.height * 0.8,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 20,
                      spreadRadius: 2.0,
                      offset: Offset(-10, 7),
                    ),
                  ],
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.grey,
                      Color.fromARGB(255, 124, 123, 123),
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
                            SignUpUser();
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
        title: const Text(
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
              decoration: const InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _phoneNumber = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _passwordController.text = value;
                });
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text('SIA Badge Type'),
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
        title: const Text('Driving License'),
        content: Column(
          children: [
            buildDrivingLicenseDropdown(),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Address'),
        content: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            buildPostalCodeInput(),
            const SizedBox(
              height: 10,
            ),
            buildHouseNumberInput(),
            ElevatedButton(
              onPressed: () {
                _getAddressFromPostalCode(_postalCodeController.text);
              },
              child: const Text('Get Address'),
            ),
            TextField(
              controller: _addressController,
              onChanged: (value) {
                setState(() {
                  _addressController.text = value;
                });
              },
              maxLines: _addressController.text.length < 50
                  ? 1
                  : _addressController.text.length < 100
                      ? 2
                      : 3,
              decoration: const InputDecoration(
                labelText: 'Address',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text('Shift Preference'),
        content: buildShiftDropdown(),
        isActive: true,
      ),
    ];
  }

  // Helper methods for building UI elements

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
      items: const [
        DropdownMenuItem(value: 'UK Full', child: Text('UK Full')),
        DropdownMenuItem(value: 'UK Automatic', child: Text('UK Automatic')),
        DropdownMenuItem(value: 'EU License', child: Text('EU License')),
        DropdownMenuItem(
            value: 'International License',
            child: Text('International License')),
        DropdownMenuItem(value: 'No License', child: Text('No License')),
      ],
      decoration: const InputDecoration(labelText: 'Select Driving License'),
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
      items: const [
        DropdownMenuItem(value: 'Day', child: Text('Day')),
        DropdownMenuItem(value: 'Night', child: Text('Night')),
        DropdownMenuItem(value: 'Any', child: Text('Any')),
      ],
      decoration: const InputDecoration(labelText: 'Select Shift'),
    );
  }

  Widget buildPostalCodeInput() {
    return TextFormField(
      controller: _postalCodeController,
      decoration: const InputDecoration(
        labelText: 'Postal Code',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buildHouseNumberInput() {
    return TextFormField(
      controller: _houseNumberController,
      decoration: const InputDecoration(
        labelText: 'House number',
        border: OutlineInputBorder(),
      ),
    );
  }

  Future<void> _getAddressFromPostalCode(String postalCode) async {
    try {
      List<Location> locations = await locationFromAddress(postalCode);
      if (locations.isNotEmpty) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          locations.first.latitude,
          locations.first.longitude,
        );
        Placemark placemark = placemarks.first;
        setState(() {
          _addressController.text =
              '${_houseNumberController.text}, ${placemark.thoroughfare},  ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}';
        });
      } else {
        setState(() {
          _addressController.text = 'No address found for $postalCode';
        });
      }
    } catch (e) {
      setState(() {
        _addressController.text = 'Error: ${e.toString()}';
      });
    }
  }
}
