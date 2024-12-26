
// ignore: depend_on_referenced_packages
import 'package:fpdart/fpdart.dart';

import 'dart:async';
import '../../../login/presentation/entities/login_error.dart';
import '../../presentation/entities/history_ui_model.dart';

abstract class HistoryRepository {
   Future<Either<LoginError, HistoryUIModels>> getHistory();
}