import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
        backgroundColor: Colors.green.shade300, // Warna hijau pastel
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Judul Tugas',
                labelStyle: TextStyle(color: Colors.green.shade400), // Hijau pastel
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Deskripsi Tugas',
                labelStyle: TextStyle(color: Colors.green.shade400), // Hijau pastel
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Tanggal Deadline',
                labelStyle: TextStyle(color: Colors.green.shade400), // Hijau pastel
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400, // Tombol hijau pastel
              ),
              child: const Text('Simpan Tugas'),
            ),
          ],
        ),
      ),
    );
  }
}
