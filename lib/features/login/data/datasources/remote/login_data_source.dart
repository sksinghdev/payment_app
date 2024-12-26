// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:payment_demo/core/feature_injection.dart';

import '../../../../../core/api_service.dart';
import '../../../../../core/connection_helper.dart';
import '../../../../../core/fuctions.dart';
import '../../../presentation/entities/login_error.dart';
import '../../../presentation/entities/login_user_ui_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import '../local/login_database_provider.dart';

class LoginRemoteDataSource {
  final Function2<Response?, String, UserUIModel?> _mapper;
  final LoginDataBaseProvider _dbProvider;
  const LoginRemoteDataSource(this._mapper, this._dbProvider);
  Future<Either<LoginError, UserUIModel>> login(
      String userName, String userPassword) async {
    final bool isInternetConnected =
        await injector<InternetConnectionHelper>().checkInternetConnection();
    final bool isDataBaseEmpty = await _dbProvider.isUserDataAvailable();
    if (isInternetConnected) {
      try {
        final response = await APIService.instance.request(
          '/users/search?q=$userName',
          DioMethod.get,
          contentType: 'application/json',
        );
        if (response.statusCode == 200) {
          var data = _mapper.call(response, userName);
          if (data != null) {
            UserUIModel? uiModel = await _getuserFromCached(
                UserUIModel(userName: data.userName, userPassword: data.userPassword), true);
            return Right(uiModel!);
          } else {
            return await insertUser(userName, userPassword);
          }
        } else {
          return Left(LoginError(error: response.statusMessage.toString()));
        }
      } catch (e) {
        return Left(LoginError(error: e.toString()));
      }
    } else {
      if (!isDataBaseEmpty) {
        log('Load [User] from Local DataBase');
        UserUIModel? uiModel = await _getuserFromCached(
            UserUIModel(userName: userName, userPassword: userName), false);

        if (uiModel != null) {
          if (uiModel.userName.toLowerCase() == userName.toLowerCase()) {
            return Right(uiModel);
          }
        }
      }
      return const Left(LoginError(error: 'No cache data found'));
    }
  }

  Future<Either<LoginError, UserUIModel>> insertUser(
      String userName, String userPassword) async {
    try {
      final response = await APIService.instance.request(
        '/users/add',
        DioMethod.post,
        param: {'firstName': userName, 'password': userPassword},
        contentType: 'application/json',
      );
      if (response.statusCode == 201) {
        UserUIModel? uiModel = await _getuserFromCached(
            UserUIModel(userName: userName, userPassword: userName), true);
        return Right(uiModel!);
      } else {
        return Left(LoginError(error: response.statusMessage.toString()));
      }
    } catch (e) {
      return Left(LoginError(error: e.toString()));
    }
  }

  Future<UserUIModel?> _getuserFromCached(
      UserUIModel uiModel, bool isInsert) async {
    if (isInsert) {
    await  _dbProvider.insertUsers(user: uiModel);
    }
    final UserUIModel? cachedUser = await _dbProvider.getUsers();
    return cachedUser;
  }
}
