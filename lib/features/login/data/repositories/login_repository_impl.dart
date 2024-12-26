import '../../domain/repositories/login_repository.dart';
import '../../presentation/entities/login_error.dart';
import '../../presentation/entities/login_user_ui_model.dart';
import '../datasources/remote/login_data_source.dart';
// ignore: depend_on_referenced_packages
import 'package:fpdart/fpdart.dart';

import 'dart:async';
class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  LoginRepositoryImpl(this.loginRemoteDataSource);

  @override
 Future<Either<LoginError, UserUIModel>> getLoginDetails(
      String userName, String userPassword) async {
   try {
      final user = await loginRemoteDataSource.login(userName,userPassword);
     return user;
    } catch (exception) {
      return Left(LoginError(error: exception.toString()));
    }
  }

}
