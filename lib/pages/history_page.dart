import 'package:flutter/material.dart';
import 'task.dart'; // Impor model Task

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final List<Task> completedTasks = [
    Task(
      title: 'Web Programming',
      description: 'Membuat web profile',
      deadline: '2024-11-18',
      isCompleted: true,
    ),
    Task(
      title: 'Bahasa Indonesia',
      description: 'Membuat tulisan singkat berjumlah 500 kata',
      deadline: '2024-11-15',
      isCompleted: true,
    ),
    // Tambahkan tugas lain sesuai kebutuhan
  ];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    // Memulai animasi daftar tugas satu per satu
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addTasksWithAnimation();
    });
  }

  void _addTasksWithAnimation() async {
    for (int i = 0; i < completedTasks.length; i++) {
      await Future.delayed(const Duration(milliseconds: 300), () {
        _listKey.currentState?.insertItem(i);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Tugas'),
        backgroundColor: Colors.green.shade300,
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: 0,
        itemBuilder: (context, index, animation) {
          final task = completedTasks[index];
          return _buildTaskItem(task, animation);
        },
      ),
    );
  }

  Widget _buildTaskItem(Task task, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text(task.title),
          subtitle: Text('Deadline: ${task.deadline}'),
          trailing: const Icon(Icons.check_circle_outline, color: Colors.green),
        ),
      ),
    );
  }
}
