import 'package:flutter/material.dart';
import 'package:task_manager_client/commons/constants.dart';
import 'package:task_manager_client/core/local_storage.dart';

class UserProvider extends ChangeNotifier {
  String _username = '';
  String _fullName = '';
  String _taskCount = '0';
  String _teamCount = '0';

  String get username => _username;
  String get fullName => _fullName;
  String get taskCount => _taskCount;
  String get teamCount => _teamCount;

  Future<void> loadUserProfile() async {
    _username = await LocalStorage.getData(Constants.username) ?? '';
    _fullName = await LocalStorage.getData(Constants.fullName) ?? '';
    _taskCount = await LocalStorage.getData(Constants.taskCount) ?? '0';
    _teamCount = await LocalStorage.getData(Constants.teamCount) ?? '0';
    notifyListeners();
  }
}
