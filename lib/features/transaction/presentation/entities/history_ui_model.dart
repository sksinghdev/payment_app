import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../../login/presentation/entities/hive/login_hive_types.dart';
part 'history_ui_model.g.dart';

@HiveType(typeId: LoginHiveTypes.userHistory)
class HistoryUIModels extends HiveObject {

  @HiveField(0)
  final List<HistoryUIModel> uiModels;

  HistoryUIModels({required this.uiModels});
}

@HiveType(typeId: LoginHiveTypes.userHistoryModels)
class HistoryUIModel extends Equatable {
  @HiveField(1)
  final String userName;
  @HiveField(2)
  final int amount;
  @HiveField(3)
  final String dataTo;

  const HistoryUIModel(
      {required this.userName, required this.amount, required this.dataTo});

  @override
  List<Object?> get props => [userName, amount, dataTo];
}
