// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_h.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserHAdapter extends TypeAdapter<UserH> {
  @override
  UserH read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
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
}
