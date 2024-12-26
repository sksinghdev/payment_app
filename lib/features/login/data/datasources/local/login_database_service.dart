// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';
import 'dart:developer';

import '../../../../../core/db_key.dart';
import '../../../domain/repositories/login_interface_repository.dart';
import '../../../presentation/entities/login_user_ui_model.dart';

class LoginDataBaseService implements LoginInterfaceRepository<UserUIModel> {
  static const String _key = DbKeys.dbUsers;
  Box<UserUIModel>? _userBox;

  LoginDataBaseService();

  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(UserUIModelAdapter());
      _userBox = await Hive.openBox<UserUIModel>(_key);
      log('Database initialized successfully for Users');
    } catch (e) {
      log('Error initializing database for Users: $e');
    }
  }

  @override
  Future<UserUIModel?> getAll() async {
    try {
      if (_userBox?.isOpen == true && _userBox?.isNotEmpty == true) {
        return _userBox?.get(_key);
      }
    } catch (e) {
      log('Error reading from database: $e');
    }
    return null;
  }

  @override
  Future<void> insertItem({required UserUIModel object}) async {
    try {
      await _userBox?.put(_key, object);
      log('User data inserted successfully');
    } catch (e) {
      log('Error inserting into database: $e');
    }
  }

  @override
  Future<bool> isDataAvailable() async {
    try {
      return _userBox?.isNotEmpty ?? false;
    } catch (e) {
      log('Error checking if database is empty: $e');
      return false;
    }
  }
}
