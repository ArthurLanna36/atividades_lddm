import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBasePage extends StatefulWidget {
  const DataBasePage({super.key});

  @override
  DataBasePageState createState() => DataBasePageState();
}

class DataBasePageState extends State<DataBasePage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

  _getData() async {
    final dataBasePath = await getDatabasesPath();
    final localDataBase = join(dataBasePath, 'data_base.db');
    var dataBaseInfo = await openDatabase(
      localDataBase,
      version: 1,
      onCreate: (dataBase, recentDataBase) {
        String sql =
          'CREATE TABLE users ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'name VARCHAR, age INTEGER';
        dataBase.execute(sql);
      }
    );
  }

  _saveData(String name, int age) async {
    Database dataBase = await _getData();
    Map<String, dynamic> userData = {
      'name': name,
      'age': age
    };
    int id = await dataBase.insert('users', userData);
  }

  _listUsers() async {
    Database dataBase = await _getData();
    String sql = 'SELECT * FROM users';
    List users = await dataBase.rawQuery(sql);
    for(var user in users) {
      if (kDebugMode) {
        print('id: ${user['id'].toString()}\nname: ${user['name']}\nage: ${user['age']}');
      }
    }
  }

  _listUser(int id) async {
    Database dataBase = await _getData();
    List users = await dataBase.query(
      'users',
      columns: ['id', 'name', 'age'],
      where: 'id = ?',
      whereArgs: [id]
    );
    for(var user in users) {
      if (kDebugMode) {
        print('id: ${user['id'].toString()}\nname: ${user['name']}\nage: ${user['age']}');
      }
    }
  }

  _updateUser(int id) async {
    Database dataBase = await _getData();
    Map<String, dynamic> userData = {
      'name':'An',
      'age':35
    };
    int returned = await dataBase.update(
      'users', userData,
      where: 'id = ?',
      whereArgs: [id]
    );
    if (kDebugMode) {
      print('Updated items: $returned');
    }
  }

  _deleteUser(int id) async {
    Database dataBase = await _getData();
    int returned = await dataBase.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id]
    );
    if (kDebugMode) {
      print('Deleted items$returned');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Data Base', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {  },
          icon: const Icon(Icons.view_headline),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Adding new user'),
                          content: Column(
                            children: [
                              const Text('Write the name and the age of the new user'),
                              TextField(
                                controller: _nameController,
                                style: const TextStyle(fontSize: 18),
                                keyboardType: TextInputType.name,
                                decoration: const InputDecoration(
                                  hintText: 'Name',
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              TextField(
                                controller: _ageController,
                                style: const TextStyle(fontSize: 18),
                                keyboardType: TextInputType.datetime,
                                decoration: const InputDecoration(
                                  hintText: 'Age',
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')
                            ),
                            TextButton(
                              onPressed: () {
                                _saveData(_nameController.text, _ageController.text as int);
                              },
                              child: const Text('Okay')
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: const Text('Add a new user')
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Listing all users'),
                          content: Column(

                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')
                            ),
                            TextButton(
                              onPressed: () {

                              },
                              child: const Text('Okay')
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: const Text('List all users')
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Listing specific user'),
                          content: const Text('Write the name and age of the new user'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')
                            ),
                            TextButton(
                              onPressed: () {

                              },
                              child: const Text('Okay')
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: const Text('List a user')
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Updating an user'),
                          content: const Text('Write the name and age of the new user'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')
                            ),
                            TextButton(
                              onPressed: () {

                              },
                              child: const Text('Okay')
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: const Text('Update an user')
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Deleting user'),
                          content: const Column(
                            children: [
                              Text('Write the id of the user that you want to delete:'),

                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel')
                            ),
                            TextButton(
                              onPressed: () {

                              },
                              child: const Text('Okay')
                            )
                          ],
                        );
                      }
                    );
                  },
                  child: const Text('Delete an user')
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}