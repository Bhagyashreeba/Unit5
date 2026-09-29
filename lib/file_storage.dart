import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MaterialApp(home: FileStorage()));

class FileStorage extends StatefulWidget {
  @override
  _FileStorageState createState() => _FileStorageState();
}

class _FileStorageState extends State<FileStorage> {
  TextEditingController _controller = TextEditingController();
  String _fileContent = "";

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  _writeFile() async {
    final file = await _localFile;
    await file.writeAsString(_controller.text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File Saved")));
  }

  _readFile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      setState(() {
        _fileContent = contents;
      });
    } catch (e) {
      setState(() {
        _fileContent = "Error reading file";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("File Storage")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _controller, decoration: InputDecoration(labelText: "Enter Text")),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: _writeFile, child: Text("Write")),
                ElevatedButton(onPressed: _readFile, child: Text("Read")),
              ],
            ),
            Text("Content: $_fileContent"),
          ],
        ),
      ),
    );
  }
}
