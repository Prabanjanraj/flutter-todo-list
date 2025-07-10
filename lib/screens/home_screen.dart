// ignore_for_file: prefer_final_fields, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/screens/addtaskscreen.dart';
import 'package:todooo/screens/calender_screen.dart';
import 'package:todooo/screens/profile.dart';
import 'package:todooo/providers/task_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController animcont;
  late final Animation<Offset> anim;
  String _selectedCategory = 'All';
  int _selectedIndex = 0; // Default to Home Page

  @override
  void initState() {
    super.initState();
    animcont = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    anim = Tween(
      begin: Offset.zero,
      end: const Offset(0, 0.05),
    ).animate(CurvedAnimation(parent: animcont, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    animcont.dispose();
    super.dispose();
  }

  /// **Handles Bottom Navigation Clicks**
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget nextScreen;
    if (index == 1) {
      nextScreen = const CalendarScreen(); // Calendar Page
    } else if (index == 2) {
      nextScreen = const ProfileScreen(
        userName: "John Doe",
        userEmail: "johndoe@example.com",
      ); // Profile Page
    } else {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  /// **Filter Tasks by Selected Category**
  List<Task> _getFilteredTasks(List<Task> tasks) {
    if (_selectedCategory == 'All') {
      return tasks;
    }
    return tasks.where((task) => task.category == _selectedCategory).toList();
  }

  /// **Shows Task Options (Mark Completed or Delete)**
  void _showTaskOptionsDialog(BuildContext context, TaskProvider taskProvider, int index) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text("Task Options"),
          content: const Text("What would you like to do with this task?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showConfirmationDialog(context, taskProvider, index, "complete");
              },
              child: const Text("Mark as Completed"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _showConfirmationDialog(context, taskProvider, index, "delete");
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  /// **Shows Confirmation Dialog Before Completing or Deleting Task**
  void _showConfirmationDialog(BuildContext context, TaskProvider taskProvider, int index, String action) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(action == "delete" ? "Delete Task?" : "Complete Task?"),
          content: Text(action == "delete"
              ? "Are you sure you want to delete this task?"
              : "Are you sure you want to mark this task as completed?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                if (action == "delete") {
                  taskProvider.deleteTask(index);
                } else {
                  taskProvider.markTaskCompleted(index);
                }
              },
              child: Text(action == "delete" ? "Delete" : "Complete"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final filteredTasks = _getFilteredTasks(taskProvider.tasks);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // **Category Selector**
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'Work', 'Personal', 'Studies', 'Birthday'].map((category) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: ElevatedButton(
                      onPressed: () => setState(() {
                        _selectedCategory = category;
                      }),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedCategory == category ? Colors.blue : Colors.grey[300],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shadowColor: Colors.black.withOpacity(0.3),
                        elevation: 6,
                      ),
                      child: Text(category, style: const TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),

            // **Task List**
            Expanded(
              child: filteredTasks.isEmpty
                  ? SlideTransition(
                      position: anim,
                      child: Image.asset(
                        'lib/images/1.jpg',
                        width: screenWidth,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = filteredTasks[index];
                        return GestureDetector(
                          onLongPress: () => _showTaskOptionsDialog(context, taskProvider, index),
                          child: Card(
                            color: Colors.white.withOpacity(0.9),
                            elevation: 6,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                      '${task.category} - ${task.date.toLocal().toString().split(' ')[0]} ${task.time.hour}:${task.time.minute}',
                                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                onTaskAdded: (task) => taskProvider.addTask(task),
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
