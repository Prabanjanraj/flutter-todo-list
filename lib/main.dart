import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todooo/models/noti_service.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/providers/task_provider.dart';
import 'package:todooo/screens/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotiService().initNotification();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  await Hive.openBox<Task>('taskBox');// Ensure Flutter is initialized
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()), // Global Task Manager
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

