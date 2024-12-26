// ignore: depend_on_referenced_packages
// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';


import 'package:hive/hive.dart';

import 'hive/login_hive_types.dart';

part 'login_user_ui_model.g.dart';

@HiveType(typeId: LoginHiveTypes.userModel)
class UserUIModel extends Equatable {

  @HiveField(0)
  final String userName;
  
  @HiveField(1)
  final String userPassword;

  const UserUIModel({required this.userName, required this.userPassword});

  @override
  List<Object?> get props => [userName, userPassword];
}
