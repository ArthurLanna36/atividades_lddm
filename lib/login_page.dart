import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tela_de_login/register_page.dart';
import 'package:tela_de_login/list_page.dart';

import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  final screens = [
    const Center(child: Text('Home', style: TextStyle(fontSize: 18))),
    const Center(child: Text('Profile', style: TextStyle(fontSize: 18))),
  ];

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  bool hidePassword = true;
  bool? checkedBox = false;

  bool correctEmail = false;
  bool correctPassword = false;

  String name = 'Arthur';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _getData() async {
    final preferences = await SharedPreferences.getInstance();
    if(_emailController.text == preferences.getString('email') && _passwordController.text == preferences.getString('password')) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/background_image.jpeg'),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: ListView(
            children: [
              Column(
              children: <Widget>[
                Column(
                  children: [
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    TextField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: const OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword ? Icons.visibility_off : Icons.visibility,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Checkbox(
                      value: checkedBox,
                      onChanged: (value) {
                        setState(() {
                          checkedBox = value;
                        });
                      },
                    ),
                    const Text('Remember me', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange
                    ),
                    onPressed: () async {
                      if(await _getData()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const MainPage())
                        );
                      }
                      else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Incorrect email or password'),
                              content: const Text('Check your data and try again'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Okay')
                                )
                              ],
                            );
                          }
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.login,
                      size: 24.0,
                    ),
                    label: const Text('Enter'),
                  ),
                ),
                const SizedBox(height: 12.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: <TextSpan> [
                            const TextSpan(text: 'New here?\n', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: 'Register\n',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const RegisterPage())
                                );
                              }
                            )
                          ]
                        )
                      ),
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}