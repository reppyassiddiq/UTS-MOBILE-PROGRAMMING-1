import 'package:flutter/material.dart';

class Task {
  final String title;
  final String description;
  final String deadline;
  final bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
    this.isCompleted = false,
  });
}

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> with TickerProviderStateMixin {
  final List<Task> _tasks = [
    Task(title: 'Belajar Flutter', description: 'Mengerjakan project UI', deadline: '2024-11-28'),
    Task(title: 'Membaca Buku', description: 'Membaca 20 halaman', deadline: '2024-11-30'),
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addTask() {
    final task = Task(
      title: 'Tugas Baru',
      description: 'Deskripsi tugas baru',
      deadline: '2024-12-01',
    );

    setState(() {
      _tasks.insert(0, task);
      _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 500));
    });
  }

  void _removeTask(int index) {
    final removedTask = _tasks[index];
    setState(() {
      _tasks.removeAt(index);
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => _buildTaskItem(removedTask, animation),
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  Widget _buildTaskItem(Task task, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(task.title),
          subtitle: Text('Deadline: ${task.deadline}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              final index = _tasks.indexOf(task);
              _removeTask(index);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addTask,
          ),
        ],
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _tasks.length,
        itemBuilder: (context, index, animation) {
          return _buildTaskItem(_tasks[index], animation);
        },
      ),
    );
  }
}
