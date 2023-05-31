import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  ListPageState createState() => ListPageState();
}

class ListPageState extends State<ListPage>{

  List items = [];

  @override
  Widget build(BuildContext context) {
    loadItems();
    return Scaffold(
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Alert'),
                    content: Text('${items[index]['subtitle']} was clicked'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {},
                        child: const Text('Stay')
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Quit')
                      )
                    ],
                  );
                }
              );
            },
            title: Text(items[index]['title']),
            subtitle: Text(items[index]['subtitle']),
          );
        }
      )
    );
  }

  void loadItems() {
    items = [];
    for(int i = 0; i <= 20; i++) {
      Map <String, dynamic> item = {};
      item['title'] = 'Item of number $i';
      item['subtitle'] = 'Subtitle of number $i';
      items.add(item);
    }
  }
}