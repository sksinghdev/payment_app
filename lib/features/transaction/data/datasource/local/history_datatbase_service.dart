// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';
import 'package:payment_demo/features/transaction/presentation/entities/history_ui_model.dart';
import 'dart:developer';

import '../../../../../core/db_key.dart';
import '../../../../login/domain/repositories/login_interface_repository.dart';

class HistoryDataBaseService
    implements LoginInterfaceRepository<HistoryUIModels> {
  static const String _key = DbKeys.dbHistory;
  Box<HistoryUIModels>? _historyBox;

  HistoryDataBaseService();

  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(HistoryUIModelsAdapter());
      _historyBox = await Hive.openBox<HistoryUIModels>(_key);
      log('Database initialized successfully for History');
    } catch (e) {
      log('Error initializing database for History: $e');
    }
  }

  @override
  Future<HistoryUIModels?> getAll() async {
    try {
      if (_historyBox?.isOpen != true && _historyBox?.isNotEmpty != true) {
         _historyBox = await Hive.openBox<HistoryUIModels>(_key);
      }
      if (_historyBox?.isOpen == true && _historyBox?.isNotEmpty == true) {
        return _historyBox?.get(_key);
      }
    } catch (e) {
      log('Error reading from database: $e');
    }
    return null;
  }

  @override
  Future<void> insertItem({required HistoryUIModels object}) async {
    try {
      await _historyBox?.put(_key, object);
      log('History data inserted successfully');
    } catch (e) {
      log('Error inserting into database: $e');
    }
  }

  @override
  Future<bool> isDataAvailable() async {
    try {
      return _historyBox?.isNotEmpty ?? false;
    } catch (e) {
      log('Error checking if database is empty: $e');
      return false;
    }
  }
}
