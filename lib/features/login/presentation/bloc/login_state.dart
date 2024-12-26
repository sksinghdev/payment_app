import '../entities/login_user_ui_model.dart';

sealed class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
   final UserUIModel uiModel;
    LoginSuccessState({required this.uiModel});
}

class LoginErrorState extends LoginState {
  final String error;
    LoginErrorState({required this.error});
}

class LoginToastErrorState extends LoginState {
  final String error;
    LoginToastErrorState({required this.error});
}