import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
    body: Center(
      child: Text("About...", style: TextStyle(fontSize: 30)),
    )
  );
}