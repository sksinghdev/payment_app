
// ignore_for_file: depend_on_referenced_packages
 
import 'package:payment_demo/features/transaction/doamin/usecases/history_usecase.dart';

import 'history_state.dart';

import 'package:bloc/bloc.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryUseCase useCase;
  HistoryCubit(this.useCase) : super(HistoryInitialState());

  void getHistory() async {
    emit(HistoryLoadingState());
    final result = await useCase.getHistory();
    result.fold(
      (failure) => emit(HistoryErrorState(error: failure.error.toString())),
      (value) => emit(HistorySuccessState(uiModel: value)),
    );
  }
}
