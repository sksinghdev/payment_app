
// ignore: depend_on_referenced_packages
import 'package:fpdart/fpdart.dart';

import 'dart:async';

import '../../../login/presentation/entities/login_error.dart';
import '../../presentation/entities/history_ui_model.dart';
import '../repositories/history_repository.dart';

class HistoryUseCase {
  final HistoryRepository historyRepo;

  HistoryUseCase({
    required this.historyRepo,
  });

  Future<Either<LoginError, HistoryUIModels>> getHistory() async {
    try {
      final response = await historyRepo.getHistory();
      return response;
    } catch (e) {
      return Left(LoginError(error: e.toString()));
    }
  }
 
}