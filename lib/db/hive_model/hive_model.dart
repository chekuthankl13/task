// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class CredentialModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String lastname;
  @HiveField(2)
  final String gender;
  @HiveField(3)
  final String nation;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String mobile;
  CredentialModel({
    required this.name,
    required this.lastname,
    required this.gender,
    required this.nation,
    required this.email,
    required this.mobile,
  });
}
