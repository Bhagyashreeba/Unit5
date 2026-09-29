import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  runApp(MaterialApp(home: HiveUser()));
}

class HiveUser extends StatefulWidget {
  @override
  _HiveUserState createState() => _HiveUserState();
}

class _HiveUserState extends State<HiveUser> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final _box = Hive.box('userBox');

  _saveUser() {
    _box.put('name', _nameController.text);
    _box.put('age', _ageController.text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive User Data")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: _ageController, decoration: InputDecoration(labelText: "Age")),
            ElevatedButton(onPressed: _saveUser, child: Text("Save")),
            SizedBox(height: 20),
            Text("Stored Name: ${_box.get('name') ?? ''}"),
            Text("Stored Age: ${_box.get('age') ?? ''}"),
          ],
        ),
      ),
    );
  }
}
