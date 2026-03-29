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

// ─── Main Notes Screen ───────────────────────────────────────────────────────

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  // Notes are now a list of maps so each note has a title AND content
  final List<Map<String, String>> notes = [
    {"title": "Buy Ganja", "content": ""},
    {"title": "Finish Flutter project", "content": ""},
    {"title": "Call mom", "content": ""},
    {"title": "Read a book", "content": ""},
    {"title": "Workout at 6 PM", "content": ""},
    {"title": "Weekend Summer hut", "content": ""},
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
        child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(notes[index]["title"]![0]),
                ),
                title: Text(notes[index]["title"]!),
                subtitle: notes[index]["content"]!.isNotEmpty
                    ? Text(
                        notes[index]["content"]!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    : const Text("Tap to see details"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // TODO: open note detail screen later
                },
              ),
            );
          },
        ),
      ),

      // ── FAB opens the Add Note Screen ──
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          // Wait for the new note to come back from AddNoteScreen
          final newNote = await Navigator.push<Map<String, String>>(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );

          // If the user saved a note, add it to our list
          if (newNote != null) {
            setState(() {
              notes.add(newNote);
            });
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

// ─── Add Note Screen ──────────────────────────────────────────────────────────

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  // Controllers read what the user types
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    // Always clean up controllers when screen closes
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      // Show a small warning if title is blank
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a title")),
      );
      return;
    }

    // Send the note back to NotesScreen
    Navigator.pop(context, {"title": title, "content": content});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "New Note",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: _saveNote,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ── Title field ──
            TextField(
              controller: _titleController,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
            const Divider(),
            // ── Content / body field ──
            Expanded(
              child: TextField(
                controller: _contentController,
                maxLines: null, // unlimited lines
                expands: true,
                decoration: const InputDecoration(
                  hintText: "Start writing your note...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}