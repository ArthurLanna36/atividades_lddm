import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tela_de_login/data_base_page.dart';

import 'package:tela_de_login/home_page.dart';
import 'package:tela_de_login/login_page.dart';
import 'package:tela_de_login/about_page.dart';
import 'package:tela_de_login/list_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
      home: LoginPage()
    )
  );
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  int currentIndex = 0;

  final screens = [
    const HomePage(),
    const AboutPage(),
    const ListPage(),
    const DataBasePage()
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepOrange,
      centerTitle: true,
      title: const Text('My App'),
    ),
    body: screens[currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.deepOrange,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      selectedFontSize: 18,
      unselectedFontSize: 18,
      currentIndex: currentIndex,
      onTap: (index) => setState(() => currentIndex = index),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: 'About'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'List'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.memory),
          label: 'Data'
        ),
      ],
    ),
  );
}
