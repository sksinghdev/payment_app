// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_ui_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryUIModelsAdapter extends TypeAdapter<HistoryUIModels> {
  @override
  final int typeId = 1;

  @override
  HistoryUIModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryUIModels(
      uiModels: (fields[0] as List).cast<HistoryUIModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HistoryUIModels obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.uiModels);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryUIModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HistoryUIModelAdapter extends TypeAdapter<HistoryUIModel> {
  @override
  final int typeId = 2;

  @override
  HistoryUIModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryUIModel(
      userName: fields[1] as String,
      amount: fields[2] as int,
      dataTo: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryUIModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.dataTo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryUIModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
