import 'package:flutter/material.dart';

class DataBasePage extends StatefulWidget {
  const DataBasePage({super.key});

  @override
  DataBasePageState createState() => DataBasePageState();
}

class DataBasePageState extends State<DataBasePage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

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
      )
    );
  }
}