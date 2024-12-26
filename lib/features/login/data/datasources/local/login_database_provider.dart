import 'dart:developer';

import '../../../presentation/entities/login_user_ui_model.dart';
import 'login_database_service.dart';

class LoginDataBaseProvider {
   final LoginDataBaseService _loginDataBaseService;

  LoginDataBaseProvider({
    required LoginDataBaseService loginDataBaseService,
  }) : _loginDataBaseService = loginDataBaseService;

   Future<UserUIModel?> getUsers() async {
    try {
      return await _loginDataBaseService.getAll();
    } catch (e) {
       log('Error retrieving categories: $e');
      return null;
    }
  }

   Future<void> insertUsers({required UserUIModel user}) async {
    try {
      await _loginDataBaseService.insertItem(object: user);
    } catch (e) {
       log('Error inserting user: $e');
    }
  }

   Future<bool> isUserDataAvailable() async {
    return await _loginDataBaseService.isDataAvailable();
  }
}
