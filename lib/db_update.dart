import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(home: DBUpdate()));

class DBUpdate extends StatefulWidget {
  @override
  _DBUpdateState createState() => _DBUpdateState();
}

class _DBUpdateState extends State<DBUpdate> {
  Database? _db;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  _initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'students_db.db'),
      version: 1,
    );
  }

  _updateStudent() async {
    int id = int.tryParse(_idController.text) ?? 0;
    await _db?.update(
      'students',
      {'name': _nameController.text},
      where: 'id = ?',
      whereArgs: [id],
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Record Updated")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Student")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _idController, decoration: InputDecoration(labelText: "Student ID to Update")),
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "New Name")),
            ElevatedButton(onPressed: _updateStudent, child: Text("Update")),
          ],
        ),
      ),
    );
  }
}
