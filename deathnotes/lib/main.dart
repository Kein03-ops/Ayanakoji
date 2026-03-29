import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatelessWidget {
  NotesScreen({super.key});

  // Example notes list
  final List<String> notes = [
    "Buy Ganja",
    "Finish Flutter project",
    "Call mom",
    "Read a book",
    "Workout at 6 PM",
    "Weekend Summer hut"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text(
          "DeathNote",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              height: 36,
              width: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text("TL"),
            ),
          )
        ],
      ),
      body: SafeArea(

        child:
        ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(notes[index][0]), // First letter
                ),
                title: Text(notes[index]),
                subtitle: const Text("Tap to see details"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  print("Tapped: ${notes[index]}");
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}