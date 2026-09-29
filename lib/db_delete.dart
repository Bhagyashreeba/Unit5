import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(home: DBDelete()));

class DBDelete extends StatefulWidget {
  @override
  _DBDeleteState createState() => _DBDeleteState();
}

class _DBDeleteState extends State<DBDelete> {
  Database? _db;
  final TextEditingController _idController = TextEditingController();

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

  _deleteStudent() async {
    int id = int.tryParse(_idController.text) ?? 0;
    await _db?.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Record Deleted")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Delete Student")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _idController, decoration: InputDecoration(labelText: "Student ID to Delete")),
            ElevatedButton(onPressed: _deleteStudent, child: Text("Delete")),
          ],
        ),
      ),
    );
  }
}
