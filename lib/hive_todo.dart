import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('todoBox');
  runApp(MaterialApp(home: HiveTodo()));
}

class HiveTodo extends StatefulWidget {
  @override
  _HiveTodoState createState() => _HiveTodoState();
}

class _HiveTodoState extends State<HiveTodo> {
  final TextEditingController _controller = TextEditingController();
  final _box = Hive.box('todoBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hive To-Do")),
      body: Column(
        children: [
          TextField(controller: _controller),
          ElevatedButton(
            onPressed: () {
              _box.put('note', _controller.text);
              setState(() {});
            },
            child: Text("Save Note"),
          ),
          Text("Saved: ${_box.get('note') ?? ''}"),
        ],
      ),
    );
  }
}
