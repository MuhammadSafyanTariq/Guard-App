import 'package:flutter/widgets.dart';
import 'package:guard/users/Models/Guard.dart';
import 'package:guard/users/Resource/Auth_Methods.dart';

class UserProvider with ChangeNotifier {
  GuardModel? _user = const GuardModel(
    FullName: '',
    uid: '',
    email: '',
    phone: '',
    BadgeType: [],
    DrivingLicence: '',
    City: '',
    Shift: '',
    type: '',
  );
  final AuthMethods _authMethods = AuthMethods();

  Future<void> refreshUser() async {
    GuardModel user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

  GuardModel get getUser => _user!;
}
