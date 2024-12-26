import 'dart:developer';

import 'package:payment_demo/features/transaction/data/datasource/local/history_datatbase_service.dart';

import '../../../presentation/entities/history_ui_model.dart';

class HistoryDataBaseProvider {
  final HistoryDataBaseService _historyDataBaseService;

  HistoryDataBaseProvider({
    required HistoryDataBaseService historyDataBaseService,
  }) : _historyDataBaseService = historyDataBaseService;

  Future<HistoryUIModels?> getHistory() async {
    try {
      return await _historyDataBaseService.getAll();
    } catch (e) {
      log('Error retrieving categories: $e');
      return null;
    }
  }

  Future<void> insertHistory({required HistoryUIModels history}) async {
    try {
      await _historyDataBaseService.insertItem(object: history);
    } catch (e) {
      log('Error inserting user: $e');
    }
  }

  Future<bool> isHistoyDataAvailable() async {
    return await _historyDataBaseService.isDataAvailable();
  }
}
