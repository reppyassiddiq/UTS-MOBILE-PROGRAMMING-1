import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_task_page.dart';
import 'pages/task_detail_page.dart';
import 'pages/history_page.dart';
import 'pages/profile_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Menentukan halaman awal
      initialRoute: '/login',
      // Menambahkan named routes
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => HomePage(),
        '/add-task': (context) => const AddTaskPage(),
        '/task-detail': (context) => const TaskDetailPage(),
        '/history': (context) => HistoryPage(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
