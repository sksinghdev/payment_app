// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_ui_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserUIModelAdapter extends TypeAdapter<UserUIModel> {
  @override
  final int typeId = 0;

  @override
  UserUIModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserUIModel(
      userName: fields[0] as String,
      userPassword: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserUIModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.userPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserUIModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
