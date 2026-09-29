import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(MaterialApp(home: DBProducts()));

class DBProducts extends StatefulWidget {
  @override
  _DBProductsState createState() => _DBProductsState();
}

class _DBProductsState extends State<DBProducts> {
  Database? _db;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  _initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'products_db.db'),
      onCreate: (db, version) {
        return db.execute("CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, price REAL)");
      },
      version: 1,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SQLite Products Table")),
      body: Center(child: Text(_db == null ? "Initializing DB..." : "Database & Table 'products' Created")),
    );
  }
}
