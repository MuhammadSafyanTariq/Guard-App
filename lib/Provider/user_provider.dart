// import 'package:flutter/widgets.dart';
// import 'package:sia/Models/Guard.dart';
// import 'package:sia/Resource/Auth_Methods.dart';

// class UserProvider with ChangeNotifier {
//   GuardModel? _user = GuardModel(
//     username: '',
//     uid: '',
//     photoUrl: '',
//     email: '',
//     bio: '',
//     followers: [],
//     following: [],
//   );
//   final AuthMethods _authMethods = AuthMethods();

//   Future<void> refreshUser() async {
//     GuardModel user = await _authMethods.getUserDetails();
//     _user = user;
//     notifyListeners();
//   }

//   GuardModel get getUser => _user!;
// }
