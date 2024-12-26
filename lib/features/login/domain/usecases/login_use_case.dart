// ignore: depend_on_referenced_packages
import 'package:fpdart/fpdart.dart';

import 'dart:async';

import 'package:payment_demo/features/login/presentation/entities/login_user_ui_model.dart';

import '../../presentation/entities/login_error.dart';
import '../repositories/login_repository.dart';



class LoginUseCase {
  final LoginRepository loginRepo;

  LoginUseCase({
    required this.loginRepo,
  });

  Future<Either<LoginError, UserUIModel>> getLoginDetails(
      String userName, String userPassword) async {
    try {
      final response = await loginRepo.getLoginDetails(userName, userPassword);
      return response;
    } catch (e) {
      return Left(LoginError(error: e.toString()));
    }
  }
 
}