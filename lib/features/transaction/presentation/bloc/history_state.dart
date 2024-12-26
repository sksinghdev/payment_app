import '../entities/history_ui_model.dart';

 
sealed class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistorySuccessState extends HistoryState {
   final HistoryUIModels uiModel;
    HistorySuccessState({required this.uiModel});
}

class HistoryErrorState extends HistoryState {
  final String error;
    HistoryErrorState({required this.error});
}
