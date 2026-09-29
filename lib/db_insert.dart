import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(home: DBInsert()));

class DBInsert extends StatefulWidget {
  @override
  _DBInsertState createState() => _DBInsertState();
}

class _DBInsertState extends State<DBInsert> {
  Database? _db;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  _initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'students_db.db'),
      onCreate: (db, version) => db.execute("CREATE TABLE students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)"),
      version: 1,
    );
  }

  _insertStudent() async {
    await _db?.insert('students', {'name': _nameController.text});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Student Inserted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Insert Student")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Student Name")),
            ElevatedButton(onPressed: _insertStudent, child: Text("Insert"))
          ],
        ),
      ),
    );
  }
}
