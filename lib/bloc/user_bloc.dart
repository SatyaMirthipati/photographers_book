import 'package:flutter/material.dart';
import 'package:photographers_book/model/profile.dart';

import '../data/local/shared_prefs.dart';
import '../repository/user_repo.dart';

class UserBloc with ChangeNotifier {
  final _userRepo = UserRepo();

  Profile? _profile;

  Profile get profile => _profile!;

  Future login({required Map<String, String> body}) async {
    var response = await _userRepo.login(body: body);
    return response;
  }

  void logout() async {
    await Prefs.clearPrefs();
    _profile = null;
  }

  Future<Profile> getProfile() async {
    _profile = await _userRepo.getProfile();
    notifyListeners();
    return _profile!;
  }

  Future registerUser({ required body}) async {
    return await _userRepo.registerUser(body: body);
  }
}
