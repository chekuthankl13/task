// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CredentialModelAdapter extends TypeAdapter<CredentialModel> {
  @override
  final int typeId = 0;

  @override
  CredentialModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CredentialModel(
      name: fields[0] as String,
      lastname: fields[1] as String,
      gender: fields[2] as String,
      nation: fields[3] as String,
      email: fields[4] as String,
      mobile: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CredentialModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lastname)
      ..writeByte(2)
      ..write(obj.gender)
      ..writeByte(3)
      ..write(obj.nation)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.mobile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CredentialModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
