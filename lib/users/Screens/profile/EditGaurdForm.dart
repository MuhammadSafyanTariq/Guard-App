import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:guard/admin/utils/GlobalVariables.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';
import 'package:guard/users/Resource/storage_methods.dart';
import 'package:guard/users/Screens/MainPage.dart';
import 'package:guard/users/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class EditGuardForm extends StatefulWidget {
  const EditGuardForm({super.key});

  @override
  _EditGuardFormState createState() => _EditGuardFormState();
}

class _EditGuardFormState extends State<EditGuardForm> {
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();
  final NameController = TextEditingController();
  final phoneController = TextEditingController();
  final licenceController = TextEditingController();
  final addressController = TextEditingController(text: addressg);
  final _postalCodeController = TextEditingController();
  final _houseNumberController = TextEditingController();
  String? gender = genderG;
  bool policeExperience = isPoliceG ?? false;
  DateTime? dateOfBirth;
  Future<String> editGuard() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    String photoUrl = imageUrlG ?? '';
    if (_image != null) {
      photoUrl =
          await StorageMehtods().uploadImagetoStorage('Images', _image!, false);
    }

    res = await _authMethods.editGuard(
      FullName: FullNameg,
      phone: phoneg,
      BadgeType: badgeTypeg.map((item) => item.toString()).toList(),
      DrivingLicence: drivingLicenceg,
      City: addressg,
      Shift: shiftg,
      dateOfBirth: dateOfBirth.toString().length > 5
          ? dateOfBirth.toString()
          : dobg ?? '',
      gender: gender ?? genderG ?? '',
      photoUrl: photoUrl,
      police: policeExperience,
      postCode: _postalCodeController.text,
    );
    await getData();

    if (imageUrlG.toString().length > 5) {
      profilePercent += 20;
    }
    if (genderG.toString().length > 1) {
      profilePercent += 5;
    }
    if (dobg.toString().length > 5) {
      profilePercent += 10;
    }

    if (isPoliceG.toString().length > 1) {
      profilePercent += 5;
    }
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
  final List<dynamic> _selectedBadgeTypes = badgeTypeg;
  String? _selectedDrivingLicense = drivingLicenceg;
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
      value: shiftg,
      onChanged: (value) {
        setState(() {
          shiftg = value!;
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
          addressg =
              '${_houseNumberController.text}, ${placemark.thoroughfare},  ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}';
        });
      } else {
        setState(() {
          addressg = 'No address found for $postalCode';
          addressg = 'No address found for $postalCode';
        });
      }
    } catch (e) {
      setState(() {
        addressg = 'Error: ${e.toString()}';
      });
    }
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

/////////////////////////////////////////////////
///////////////////////////////////
  ///
////
////
////
////
////
////
////
////
////
////
////
////
////
//////
////
////
////
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;
    NameController.text = FullNameg;
    phoneController.text = phoneg;
    licenceController.text = drivingLicenceg;
    addressController.text = addressg;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Guard Registration',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Container(
                padding: const EdgeInsets.all(20),
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
                      Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: MemoryImage(_image!),
                                  radius: 50,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      imageUrlG ?? emptyAvatarImage),
                                  radius: 50,
                                ),
                          Positioned(
                              top: 60,
                              left: 64,
                              child: IconButton(
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  selectImage();
                                },
                              ))
                        ],
                      ),
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
        title: const Text(
          'Personal Information',
          style: TextStyle(color: Colors.black),
        ),
        content: Column(
          children: [
            TextField(
              controller: NameController,
              onChanged: (value) {
                setState(() {
                  FullNameg = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            TextField(
              controller: phoneController,
              onChanged: (value) {
                setState(() {
                  phoneg = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: const Text(
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
              controller: addressController,
              onChanged: (value) {
                setState(() {
                  addressg = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'address',
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
      Step(
        title: Text('Gender'),
        content: Column(
          children: [
            RadioListTile(
              title: Text('Male'),
              value: 'Male',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value as String;
                });
              },
            ),
            RadioListTile(
              title: Text('Female'),
              value: 'Female',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value as String;
                });
              },
            ),
            RadioListTile(
              title: Text('Prefer Not to Say'),
              value: 'Prefer Not to Say',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value as String;
                });
              },
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Date of Birth'),
        content: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != dateOfBirth) {
                  setState(() {
                    dateOfBirth = picked;
                  });
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: Text('Select Date of Birth'),
            ),
            Text(
              dateOfBirth != null
                  ? 'My Date of Birth: ${dateOfBirth.toString().substring(0, 10)}'
                  : dobg.toString().length > 5
                      ? 'My Date of Birth: ${dobg.toString().substring(0, 10)}'
                      : 'No Date Selected',
            ),
          ],
        ),
        isActive: true,
      ),
      Step(
        title: Text('Police or Military Experience'),
        content: Column(
          children: [
            Text('Do you have Police or Military Experience?'),
            SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          policeExperience ? Colors.black : Colors.white),
                  onPressed: () {
                    setState(() {
                      policeExperience = true;
                    });
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(
                        color: policeExperience ? Colors.white : Colors.black),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          policeExperience ? Colors.white : Colors.black),
                  onPressed: () {
                    setState(() {
                      policeExperience = false;
                    });
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                        color: policeExperience ? Colors.black : Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
        isActive: true,
      ),
    ];
  }
}

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:guard/admin/utils/GlobalVariables.dart';
// import 'package:guard/users/Resource/Auth_Methods.dart';
// import 'package:guard/users/Screens/MainPage.dart';
// import 'package:guard/users/utils/utils.dart';
// import 'package:uuid/uuid.dart';

// class EditGuardForm extends StatefulWidget {
//   @override
//   _EditGuardFormState createState() => _EditGuardFormState();
// }

// class _EditGuardFormState extends State<EditGuardForm> {
//   bool _isLoading = false;
//   final AuthMethods _authMethods = AuthMethods();
//   final NameController = TextEditingController();
//   final emailController = TextEditingController();
//   final phoneController = TextEditingController();
//   final licenceController = TextEditingController();
//   final addressController = TextEditingController();
//   final shiftController = TextEditingController();
//   final _postalCodeController = TextEditingController();
//   final _houseNumberController = TextEditingController();
//   final _addressController = TextEditingController();
//   String password = '';
//   Future<String> editGuard() async {
//     String res = '';
//     setState(() {
//       _isLoading = true;
//     });
//     res = await _authMethods.editGuard(
//       FullName: FullNameg!,
//       phone: phoneg,
//       BadgeType: badgeTypeg.map((item) => item.toString()).toList(),
//       DrivingLicence: drivingLicenceg,
//       City: cityg,
//       Shift: shiftg,
//       address2: '',
//       dateOfBirth: '',
//       gender: '',
//       photoUrl: '',
//       police: false,
//       postCode: '',
//     );
//     // setState(() {
//     //   _isLoading = false;
//     // });
//     if (res != 'success') {
//       showSnackBar(res, context);
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => MainPage(),
//         ),
//       );
//     }
//     return res;
//   }

//   int _currentStep = 0;

//   // For checkboxes and dropdown values
//   List<String> _selectedBadgeTypes = [];
//   String? _selectedDrivingLicense;
//   String? address;
//   String _selectedShiftPreferences = 'Day';
//   String? _fullName;
//   String? _phoneNumber;
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
//     _selectedBadgeTypes = badgeTypeg.map((item) => item.toString()).toList();
//     return CheckboxListTile(
//       title: Text(title),
//       value: _selectedBadgeTypes.contains(title),
//       onChanged: (value) {
//         setState(() {
//           if (value ?? false) {
//             badgeTypeg.add(title);
//           } else {
//             badgeTypeg.remove(title);
//           }
//         });
//       },
//     );
//   }

//   Widget buildDrivingLicenseDropdown() {
//     _selectedDrivingLicense = drivingLicenceg;
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
//     _selectedShiftPreferences = shiftg;
//     return DropdownButtonFormField<String>(
//       value: _selectedShiftPreferences,
//       onChanged: (value) {
//         setState(() {
//           shiftg = value!;
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

//   Widget buildPostalCodeInput() {
//     return TextFormField(
//       controller: _postalCodeController,
//       decoration: const InputDecoration(
//         labelText: 'Postal Code',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   Widget buildHouseNumberInput() {
//     return TextFormField(
//       controller: _houseNumberController,
//       decoration: const InputDecoration(
//         labelText: 'House number',
//         border: OutlineInputBorder(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     double W = MediaQuery.of(context).size.width;
//     double H = MediaQuery.of(context).size.height;
//     NameController.text = FullNameg;
//     phoneController.text = phoneg;
//     licenceController.text = drivingLicenceg;
//     addressController.text = cityg;
//     shiftController.text = shiftg;
//     emailController.text = emailg;
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
//                       editGuard();
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
//               controller: NameController,
//               onChanged: (value) {
//                 setState(() {
//                   FullNameg = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Full Name',
//                 labelStyle: TextStyle(color: Colors.black),
//               ),
//             ),
//             TextField(
//               controller: phoneController,
//               onChanged: (value) {
//                 setState(() {
//                   phoneg = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
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
//             SizedBox(
//               height: 10,
//             ),
//             buildPostalCodeInput(),
//             SizedBox(
//               height: 10,
//             ),
//             buildHouseNumberInput(),
//             ElevatedButton(
//               onPressed: () {
//                 _getAddressFromPostalCode(_postalCodeController.text);
//               },
//               child: const Text('Get Address'),
//             ),
//             TextField(
//               controller: addressController,
//               onChanged: (value) {
//                 setState(() {
//                   cityg = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: '',
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
