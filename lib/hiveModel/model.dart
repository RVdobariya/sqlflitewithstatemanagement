import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;
  @HiveField(2)
  final List<String> friends;

  Person({required this.name, required this.age, required this.friends});
}
