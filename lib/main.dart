import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'sp_username.dart';
import 'sp_dark_mode.dart';
import 'db_products.dart';
import 'db_insert.dart';
import 'db_listview.dart';
import 'db_update.dart';
import 'db_delete.dart';
import 'hive_todo.dart';
import 'hive_user.dart';
import 'file_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainMenu(),
  ));
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> apps = [
      {'name': '1. SP: Save Username', 'page': SPUsername()},
      {'name': '2. SP: Dark Mode Switch', 'page': SPDarkModeApp()},
      {'name': '3. DB: Products Table', 'page': DBProducts()},
      {'name': '4. DB: Insert Student', 'page': DBInsert()},
      {'name': '5. DB: Student List', 'page': DBListView()},
      {'name': '6. DB: Update Record', 'page': DBUpdate()},
      {'name': '7. DB: Delete Record', 'page': DBDelete()},
      {'name': '8. Hive: To-Do Note', 'page': HiveTodo()},
      {'name': '9. Hive: Username & Age', 'page': HiveUser()},
      {'name': '10. File Storage (Path Provider)', 'page': FileStorage()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("MAD Practical Programs Menu"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text("${index + 1}", style: const TextStyle(color: Colors.white)),
              ),
              title: Text(
                apps[index]['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => apps[index]['page']),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
