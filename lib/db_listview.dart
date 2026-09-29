import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(home: DBListView()));

class DBListView extends StatefulWidget {
  @override
  _DBListViewState createState() => _DBListViewState();
}

class _DBListViewState extends State<DBListView> {
  Database? _db;
  List<Map<String, dynamic>> _records = [];

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
    _loadRecords();
  }

  _loadRecords() async {
    final data = await _db?.query('students');
    setState(() {
      _records = data ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Student List")),
      body: ListView.builder(
        itemCount: _records.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(_records[index]['name']),
          subtitle: Text("ID: ${_records[index]['id']}"),
        ),
      ),
    );
  }
}
