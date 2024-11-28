import 'package:flutter/material.dart';
import 'add_task_page.dart';
import 'history_page.dart';
import 'profile_page.dart';
import 'task_detail_page.dart';
import 'task.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Daftar tugas
  final List<Task> tasks = [
    Task(
      title: 'Mobile Programming',
      description: 'Project UTS',
      deadline: '2024-11-28',
      isCompleted: false, // Tugas belum selesai
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: Colors.green.shade300, // Warna hijau pastel untuk AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Selamat datang kembali!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins', // Menggunakan font Poppins
                color: Color.fromARGB(255, 67, 157, 72), // Menggunakan warna hijau pastel
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Apakah tugasnya sudah selesai? Jangan lupa dikerjakan yaaa!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontFamily: 'Poppins', // Menggunakan font Poppins
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: task.isCompleted
                        ? Colors.green.shade100 // Hijau pastel jika selesai
                        : Colors.red.shade100, // Merah pastel jika belum selesai
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(fontFamily: 'Poppins'), // Menggunakan font Poppins
                    ),
                    subtitle: Text(
                      'Deadline: ${task.deadline}',
                      style: TextStyle(fontFamily: 'Poppins'), // Menggunakan font Poppins
                    ),
                    trailing: task.isCompleted
                        ? const Icon(Icons.check_circle_outline, color: Colors.green) // Tugas selesai
                        : const CircularProgressIndicator(), // Tugas belum selesai
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              const TaskDetailPage(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            var offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AddTaskPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green.shade400, // Hijau pastel pada FAB
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HistoryPage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
