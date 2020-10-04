// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHAdapter extends TypeAdapter<UserH> {
  @override
  final int typeId = 0;

  @override
  UserH read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserH(
      id: fields[0] as int,
      name: fields[1] as String,
      username: fields[2] as String,
      phone: fields[3] as String,
      email: fields[4] as String,
      website: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserH obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.phone)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.website);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserHAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
