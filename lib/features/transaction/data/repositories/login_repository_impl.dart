import '../../../login/presentation/entities/login_error.dart';
import '../../doamin/repositories/history_repository.dart';
import '../../presentation/entities/history_ui_model.dart';
// ignore: depend_on_referenced_packages
import 'package:fpdart/fpdart.dart';

import 'dart:async';

import '../datasource/history_datasource.dart';
class HiustoryRepositoryImpl extends HistoryRepository {
  final HistoryDataSource historyDataSource;
  HiustoryRepositoryImpl(this.historyDataSource);

  @override
 Future<Either<LoginError, HistoryUIModels>>  getHistory() async {
   try {
      final user = await historyDataSource.getHistory();
     return user;
    } catch (exception) {
      return Left(LoginError(error: exception.toString()));
    }
  }

}
