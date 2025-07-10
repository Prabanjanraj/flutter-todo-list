import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String category;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  TimeOfDay time; 

  @HiveField(4)
  bool isCompleted = false;

  @HiveField(5)
  bool reminder = false;

  Task({
    required this.name,
    required this.category,
    required this.date,
    required this.time,
    this.isCompleted = false,
    this.reminder = false
  });
}
