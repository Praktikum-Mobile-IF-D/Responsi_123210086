// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobsAdapter extends TypeAdapter<Jobs> {
  @override
  final int typeId = 0;

  @override
  Jobs read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Jobs()
      ..jobTitle = fields[0] as String?
      ..companyLogo = fields[1] as String?
      ..companyName = fields[2] as String?
      ..annualSalaryMin = fields[3] as String?
      ..annualSalaryMax = fields[4] as String?
      ..jobIndustry = (fields[5] as List?)?.cast<String>()
      ..jobExcerpt = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, Jobs obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.jobTitle)
      ..writeByte(1)
      ..write(obj.companyLogo)
      ..writeByte(2)
      ..write(obj.companyName)
      ..writeByte(3)
      ..write(obj.annualSalaryMin)
      ..writeByte(4)
      ..write(obj.annualSalaryMax)
      ..writeByte(5)
      ..write(obj.jobIndustry)
      ..writeByte(6)
      ..write(obj.jobExcerpt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
