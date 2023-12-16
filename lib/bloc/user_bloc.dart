import 'package:flutter/material.dart';

import '../data/local/shared_prefs.dart';
import '../repository/user_repo.dart';

class UserBloc with ChangeNotifier {
  final _userRepo = UserRepo();

  String? _profile;

  String get profile => _profile!;


  Future login({required Map<String, String> body}) async {
    var response = await _userRepo.login(body: body);
    var token = response['Token'];
    await Prefs.setToken(token);
    notifyListeners();
    return response;
  }

  void logout() async {
    await Prefs.clearPrefs();
    _profile = null;
  }

  Future getProfile() async {
    _profile = await _userRepo.getProfile();
    notifyListeners();
    return _profile!;
  }
}
