// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import '../../../../core/api_service.dart';
import '../../../../core/connection_helper.dart';
import '../../../../core/feature_injection.dart';
import '../../../../core/fuctions.dart';
import '../../../login/presentation/entities/login_error.dart';
import '../../presentation/entities/history_ui_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import "package:collection/collection.dart";

import '../entities/history_domain_model.dart';
import 'local/history_database_provider.dart';

class HistoryDataSource {
  final Function1<Response, HistoryDomainModel> _mapper;
  final HistoryDataBaseProvider _dbProvider;
  const HistoryDataSource(this._mapper, this._dbProvider);

  Future<Either<LoginError, HistoryUIModels>> getHistory() async {
    try {
      final bool isInternetConnected =
          await injector<InternetConnectionHelper>().checkInternetConnection();
      final bool isDataBaseEmpty = await _dbProvider.isHistoyDataAvailable();
      if (isInternetConnected) {
        final response = await APIService.instance.request(
          '/c/3531-25b9-492e-9e48',
          DioMethod.get,
          contentType: 'application/json',
        );
        if (response.statusCode == 200) {
          var data = _mapper.call(response);
          HistoryUIModels? uiModel = await _getHistoryFromCached(
              HistoryUIModels(uiModels: _getUimodels(data)));
          return Right(uiModel!);
        } else {
          return Left(LoginError(error: response.statusMessage!));
        }
      } else {
        if (!isDataBaseEmpty) {
          log('Load [History] from Local DataBase');
          var uiModel = await _dbProvider.getHistory();

          if (uiModel != null) {
            return Right(uiModel);
          }
        }
        return const Left(LoginError(error: 'No cache data found'));
      }
    } catch (e) {
      return Left(LoginError(error: e.toString()));
    }
  }

  List<HistoryUIModel> _getUimodels(HistoryDomainModel uiModels) {
    return uiModels.history
            .map((history) {
              return HistoryUIModel(
                  amount: history.amount,
                  userName: history.name,
                  dataTo: history.data.toString());
            })
            .toList() ;
  }

  Future<HistoryUIModels?> _getHistoryFromCached(
      HistoryUIModels uiModel) async {
    await _dbProvider.insertHistory(history: uiModel);
    var cachedHistory = await _dbProvider.getHistory();
    return cachedHistory;
  }
}
