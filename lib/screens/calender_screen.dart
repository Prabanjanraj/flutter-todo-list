// ignore_for_file: deprecated_member_use, unused_local_variable, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todooo/models/task.dart';
import 'package:todooo/screens/home_screen.dart';
import 'package:todooo/screens/profile.dart';
import 'package:todooo/providers/task_provider.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  int _selectedIndex = 1; // Default to Calendar Page

  @override
  void initState() {
    super.initState();
    _selectedDay = _stripTime(DateTime.now());
    _focusedDay = _stripTime(DateTime.now());
  }

  /// **Removes Time from DateTime**
  DateTime _stripTime(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// **Handles Bottom Navigation Clicks**
  void _onItemTapped(int index) {
    if (index == _selectedIndex) return; // Prevents reloading same page

    Widget nextScreen;
    if (index == 0) {
      nextScreen = const HomeScreen();
    } else if (index == 2) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      nextScreen = ProfileScreen(
        userName: "John Doe",
        userEmail: "johndoe@example.com",
      );
    } else {
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    Map<DateTime, List<Task>> tasksByDate = {};

    /// **Group Tasks by Date**
    for (var task in taskProvider.tasks) {
      DateTime taskDate = _stripTime(task.date);
      tasksByDate.putIfAbsent(taskDate, () => []).add(task);
    }

    final tasksForSelectedDay = tasksByDate[_selectedDay] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Task Calendar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2100),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rowHeight: 40,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = _stripTime(selectedDay);
                  _focusedDay = _stripTime(focusedDay);
                });
              },
              eventLoader: (day) => tasksByDate[_stripTime(day)] ?? [],
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 3,
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                defaultTextStyle: const TextStyle(color: Colors.black),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold),
                leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.blue),
                rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.blue),
              ),
            ),
          ),

          // **Task List for Selected Date**
          Expanded(
            child: tasksForSelectedDay.isNotEmpty
                ? ListView.builder(
                    itemCount: tasksForSelectedDay.length,
                    itemBuilder: (context, index) {
                      Task task = tasksForSelectedDay[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.1),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            task.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          subtitle: Text(
                            task.category,
                            style: const TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text(
                      "No tasks for this day",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
          ),
        ],
      ),

      // **Bottom Navigation Bar**
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
