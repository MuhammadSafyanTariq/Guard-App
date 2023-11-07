import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:guard/Employer/Screen/MainPage2.dart';
import 'package:guard/admin/Resource/Auth_Methods.dart';
import 'package:guard/admin/utils/GlobalVariables.dart';
import 'package:guard/users/Resource/storage_methods.dart';
import 'package:guard/users/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class EditEmployerForm extends StatefulWidget {
  @override
  _EditEmployerFormState createState() => _EditEmployerFormState();
}

class _EditEmployerFormState extends State<EditEmployerForm> {
  int _currentStep = 0;

  final TextEditingController _companyNameController =
      TextEditingController(text: FullNameg);
  final TextEditingController _addressController =
      TextEditingController(text: addressg);
  final TextEditingController _phoneController =
      TextEditingController(text: phoneg);
  final TextEditingController _emailController =
      TextEditingController(text: emailg);
  final TextEditingController _corresPersonController =
      TextEditingController(text: correspondingPersong);
  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  Future<String> editProfile() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    String photoUrl = imageUrlG ?? '';
    if (_image != null) {
      photoUrl =
          await StorageMehtods().uploadImagetoStorage('Images', _image!, false);
    }
    print('pppppppppppppppppppppppppppp$photoUrl');
    res = await _authMethods.editProfile(
      companyName: _companyNameController.text,
      address: _addressController.text,
      phone: _phoneController.text,
      correspondingPerson: _corresPersonController.text,
      imageUrl: photoUrl,
    );
    setState(() {
      _isLoading = false;
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage2(),
        ));
    if (res != 'success') {
      showSnackBar(res, context);
    } else {}
    return res;
  }

  late List<Step> _steps;

  @override
  void initState() {
    super.initState();

    _steps = [
      Step(
        title: Text('Company Information'),
        content: Column(
          children: [
            TextField(
              controller: _companyNameController,
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: _corresPersonController,
              decoration:
                  InputDecoration(labelText: 'Corresponding Person Name'),
            ),
          ],
        ),
        isActive: true,
      ),
    ];
  }

  @override
  void dispose() {
    // Dispose of the TextEditingControllers here.
    _companyNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _corresPersonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double W = MediaQuery.of(context).size.width;
    double H = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Employer Registration'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          steps: _steps,
                          currentStep: _currentStep,
                          onStepTapped: (step) {
                            setState(() {
                              _currentStep = step;
                            });
                          },
                          onStepContinue: () {
                            if (_currentStep < _steps.length - 1) {
                              setState(() {
                                _currentStep++;
                              });
                            } else {
                              editProfile();
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
        ],
      ),
    );
  }
}
