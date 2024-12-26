
// ignore: depend_on_referenced_packages
import 'package:fpdart/fpdart.dart';

import 'dart:async';
import '../../presentation/entities/login_error.dart';
import '../../presentation/entities/login_user_ui_model.dart';

abstract class LoginRepository {
  Future<Either<LoginError, UserUIModel>> getLoginDetails(String userName, String userPassword);
}