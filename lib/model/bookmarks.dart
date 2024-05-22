import 'package:hive/hive.dart';

part 'bookmarks.g.dart';

@HiveType(typeId: 0)
class Jobs {
  @HiveField(0)
  String? jobTitle;

  @HiveField(1)
  String? companyLogo;

  @HiveField(2)
  String? companyName;

  @HiveField(3)
  String? annualSalaryMin;

  @HiveField(4)
  String? annualSalaryMax;

  @HiveField(5)
  List<String>? jobIndustry;

  @HiveField(6)
  String? jobExcerpt;
}
