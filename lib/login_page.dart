import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:tela_de_login/register_page.dart';
import 'package:tela_de_login/list_page.dart';

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

  TextEditingController _textEditingController = TextEditingController();

  bool hidePassword = true;
  bool? checkedBox = false;

  bool correctEmail = false;
  bool correctPassword = false;

  String name = 'Arthur';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/background_image.jpeg'),
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                      border: OutlineInputBorder(),
                      fillColor: Colors.white,
                      filled: true
                    ),
                    onSubmitted: (String submitted){
                      if(submitted == 'eu@gmail.com')
                      {
                        correctEmail = true;
                      }
                    }
                  ),
                  const SizedBox(height: 12.0),
                  TextField(
                    keyboardType: TextInputType.number,
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
                    onSubmitted: (String submitted) {
                      if(submitted == '1234') {
                        correctPassword = true;
                      }
                    }
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
                  onPressed: () {
                    if(correctEmail == true && correctPassword == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ListPage(name: name))
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
                            text: 'Clickable\n',
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
        ),
      ),
    );
  }
}