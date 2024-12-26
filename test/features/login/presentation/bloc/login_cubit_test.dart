import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:payment_demo/features/login/domain/usecases/login_use_case.dart';
import 'package:payment_demo/features/login/presentation/bloc/login_cubit.dart';
import 'package:payment_demo/features/login/presentation/bloc/login_state.dart';
import 'package:payment_demo/features/login/presentation/entities/login_error.dart';
import 'package:payment_demo/features/login/presentation/entities/login_user_ui_model.dart';
 // Mock LoginUseCase
class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockUserUIModel extends Mock implements UserUIModel {}

void main() {
  late MockLoginUseCase mockLoginUseCase;
  late LoginCubit loginCubit;
  late MockUserUIModel mockUserUIModel;


  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    loginCubit = LoginCubit(mockLoginUseCase);
     mockUserUIModel = MockUserUIModel();
   });

  tearDown(() {
    loginCubit.close();
  });

  group('LoginCubit Tests', () {
    const String validUserName = 'test_user';
    const String validPassword = 'password123';

    const String invalidUserName = '';
    const String invalidPassword = '';

 
    test('Initial state is LoginInitialState', () {
      expect(loginCubit.state, isA<LoginInitialState>());
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoadingState, LoginSuccessState] when login is successful',
      setUp: () {
         when(mockLoginUseCase.getLoginDetails(validUserName, validPassword))
            .thenAnswer((_) => Future.value(Either.right(mockUserUIModel)));
      },
      build: () => loginCubit,
      
      act: (cubit) => cubit.doLogin(validUserName, validPassword),
      expect: () => [isA<LoginLoadingState>(), isA<LoginSuccessState>()],
      verify: (_) {
        verify(mockLoginUseCase.getLoginDetails(validUserName, validPassword))
            .called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoadingState, LoginErrorState] when login fails',
      build: () {
        when(mockLoginUseCase.getLoginDetails(validUserName, validPassword))
            .thenAnswer((_) =>
                Future.value(const Left(LoginError(error: 'Login Failed'))));
        return loginCubit;
      },
      act: (cubit) => cubit.doLogin(validUserName, validPassword),
      expect: () => [
        LoginLoadingState(),
        LoginErrorState(error: 'Login Failed'),
      ],
      verify: (_) {
        verify(mockLoginUseCase.getLoginDetails(validUserName, validPassword))
            .called(1);
      },
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginToastErrorState] when username or password is invalid',
      build: () => loginCubit,
      act: (cubit) => cubit.checkLogin(invalidUserName, invalidPassword),
      expect: () => [
        isA<LoginToastErrorState>()
      ],
      verify: (_) {
        verifyNever(mockLoginUseCase.getLoginDetails('userName', 'password'));
      },
    );
  });
}
