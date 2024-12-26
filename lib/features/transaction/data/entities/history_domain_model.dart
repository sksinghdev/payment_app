// To parse this JSON data, do
//
//     final historyDomainModel = historyDomainModelFromJson(jsonString);

import 'dart:convert';

HistoryDomainModel historyDomainModelFromJson(String str) => HistoryDomainModel.fromJson(json.decode(str));

String historyDomainModelToJson(HistoryDomainModel data) => json.encode(data.toJson());

class HistoryDomainModel {
    final List<History> history;

    HistoryDomainModel({
        required this.history,
    });

    factory HistoryDomainModel.fromJson(Map<String, dynamic> json) => HistoryDomainModel(
        history: List<History>.from(json["history"].map((x) => History.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
    };
}

class History {
    final String name;
    final int amount;
    final DateTime data;

    History({
        required this.name,
        required this.amount,
        required this.data,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        name: json["name"],
        amount: json["amount"],
        data: DateTime.parse(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "amount": amount,
        "data": "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}",
    };
}
