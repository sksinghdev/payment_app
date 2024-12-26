import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_demo/features/transaction/presentation/bloc/history_cubit.dart';
import 'package:payment_demo/features/transaction/presentation/bloc/history_state.dart';
import 'package:payment_demo/features/transaction/presentation/widget/histor_widget.dart';
import 'package:toastification/toastification.dart';

import '../../../../core/feature_injection.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => injector<HistoryCubit>(),
        child: BlocConsumer<HistoryCubit, HistoryState>(
          listenWhen: (_, state) => state is HistoryErrorState,
          listener: (context, state) {
            switch (state) {
              case HistoryErrorState():
                toastification.show(
                  type: ToastificationType.error,
                  context: context, // optional if you use ToastificationWrapper
                  title: Text(state.error),
                  autoCloseDuration: const Duration(seconds: 2),
                );
              default:
            }
          },
          builder: (context, state) => _getLoginComponent(context, state),
        ),
      ),
    );
  }

  Widget _getLoginComponent(BuildContext context, HistoryState state) {
    switch (state) {
      case HistoryInitialState():
        context.read<HistoryCubit>().getHistory();
        return const Center(child:   CircularProgressIndicator());
      case HistoryLoadingState():
        return const Center(child:   CircularProgressIndicator());
      case HistorySuccessState():
        return ListView.builder(itemBuilder: (context, i) {
          return HistoryWidget(uiModel: state.uiModel.uiModels[1]);
        });
      default:
        return const Center(child:   CircularProgressIndicator());
    }
  }
}
