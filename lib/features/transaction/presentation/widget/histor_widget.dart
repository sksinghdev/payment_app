import 'package:flutter/material.dart';
import 'package:payment_demo/features/transaction/presentation/entities/history_ui_model.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key, required this.uiModel});
  final HistoryUIModel uiModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(uiModel.userName),
            ),
            const SizedBox(width: 16.0),
            Text(
              uiModel.amount.toString(),
            ),
          ],
        ),
        Text(
          uiModel.dataTo,
        ),
      ],
    );
  }
}
