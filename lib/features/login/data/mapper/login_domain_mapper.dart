// ignore_for_file: depend_on_referenced_packages

import '../../../../core/fuctions.dart';
import '../../presentation/entities/login_user_ui_model.dart';

import '../entities/user_domain_model.dart';
import 'package:dio/dio.dart';
class LoginDomainMapper implements Function2<Response?, String, UserUIModel?> {
  @override
  UserUIModel? call(Response? josnValue, String userName) {



    UserDomainModel user = UserDomainModel.fromJson(josnValue?.data);
    if (user.users != null) {
      if (user.users!.isNotEmpty) {
        Users result = user.users!.firstWhere(
            (element) =>
                (element.username!.toLowerCase() == userName.toLowerCase()),
            orElse: () => Users());
        if (result.id != null) {
          return UserUIModel(
              userName: result.username!, userPassword: result.password!);
        }
      }
    }
    return null;
  }
}
