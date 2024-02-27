// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      email: fields[1] as String?,
      latLong: fields[2] as LatLng?,
      name: fields[3] as String?,
      phone: fields[4] as String?,
      profileImage: fields[5] as String?,
      uid: fields[6] as String?,
      uType: fields[7] as String?,
      fcmToken: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.latLong)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.profileImage)
      ..writeByte(6)
      ..write(obj.uid)
      ..writeByte(7)
      ..write(obj.uType)
      ..writeByte(8)
      ..write(obj.fcmToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LatLngAdapter extends TypeAdapter<LatLng> {
  @override
  final int typeId = 2;

  @override
  LatLng read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LatLng(
      latitude: fields[1] as double?,
      longitude: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, LatLng obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LatLngAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
