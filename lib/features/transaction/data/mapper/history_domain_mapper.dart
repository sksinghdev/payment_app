import 'package:payment_demo/core/fuctions.dart';
import 'package:dio/dio.dart';

import '../entities/history_domain_model.dart';

class HistoryDomainMapper implements Function1<Response, HistoryDomainModel> {
  @override
  HistoryDomainModel call(Response response) {
    HistoryDomainModel history = HistoryDomainModel.fromJson(response.data);

    return history;
  }
}
