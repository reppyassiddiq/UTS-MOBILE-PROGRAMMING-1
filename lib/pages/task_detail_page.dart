import 'package:flutter/material.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Tugas'),
        backgroundColor: Colors.green.shade300, // Hijau pastel untuk AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Judul: Mobile Programming',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Deskripsi: Project UTS'),
            const SizedBox(height: 10),
            const Text('Deadline: 2024-11-28'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400, // Hijau pastel pada tombol
              ),
              child: const Text('Tandai Selesai'),
            ),
          ],
        ),
      ),
    );
  }
}
