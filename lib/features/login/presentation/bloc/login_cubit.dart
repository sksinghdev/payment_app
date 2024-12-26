
// ignore_for_file: depend_on_referenced_packages

import '../../domain/usecases/login_use_case.dart';
import 'login_state.dart';

import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase useCase;
  LoginCubit(this.useCase) : super(LoginInitialState());

  void doLogin(String userName, String userPassword) async {
    emit(LoginLoadingState());
    final result = await useCase.getLoginDetails(userName, userPassword);
    result.fold(
      (failure) => emit(LoginErrorState(error: failure.error.toString())),
      (value) => emit(LoginSuccessState(uiModel: value)),
    );
  }

  void checkLogin(String? userName, String? userPassword) async {
    if (userName == null ||
        userName.isEmpty ||
        userPassword == null ||
        userPassword.isEmpty) {
      emit(LoginToastErrorState(error: 'Invalid user name'));
    }
    if (userName != null &&
        userName.isNotEmpty &&
        userPassword != null &&
        userPassword.isNotEmpty) {
      doLogin(userName, userPassword);
    }
  }
}
