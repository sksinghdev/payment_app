// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';

class LoginError extends Equatable {
  final String error;

  const LoginError({required this.error});

  @override
  List<Object?> get props => [error];
}
