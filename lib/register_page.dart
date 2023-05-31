import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tela_de_login/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _saveData() async {
    String typedName = _nameController.text;
    String typedBirth = _birthController.text;
    String typedEmail = _emailController.text;
    String typedPhone = _phoneController.text;
    String typedPassword = _passwordController.text;
    String typedGender = selectedGender;
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('name', typedName);
    await preferences.setString('birth', typedBirth);
    await preferences.setString('email', typedEmail);
    await preferences.setString('phone', typedPhone);
    await preferences.setString('password', typedPassword);
    await preferences.setString('gender', typedGender);
  }

  bool hidePassword = true;
  late String selectedGender = 'male';

  bool notifyEmail = false;
  bool notifyCellphone = false;

  double myFontSize = 18;
  String sliderLabel = '';

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text('Create an Account', style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {  },
          icon: const Icon(Icons.view_headline),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: ListView(
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(fontSize: myFontSize),
              keyboardType: TextInputType.name,
              maxLength: 20,
              decoration: const InputDecoration(
                hintText: 'Name',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _birthController,
              style: TextStyle(fontSize: myFontSize),
              keyboardType: TextInputType.datetime,
              maxLength: 10,
              decoration: const InputDecoration(
                hintText: 'Date of Birth',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _emailController,
              style: TextStyle(fontSize: myFontSize),
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
              controller: _phoneController,
              style: TextStyle(fontSize: myFontSize),
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true
              ),
            ),
            const SizedBox(height: 12.0),
            TextField(
              controller: _passwordController,
              style: TextStyle(fontSize: myFontSize),
              obscureText: hidePassword,
              maxLength: 20,
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
                )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Gender:', style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.bold)),
                Radio(
                  value: "male",
                  groupValue: selectedGender,
                  onChanged: (String? answer) {
                    setState(() {
                      selectedGender = answer!;
                    });
                  }
                ),
                Text('Male', style: TextStyle(fontSize: myFontSize)),
                Radio(
                  value: "female",
                  groupValue: selectedGender,
                  onChanged: (String? answer) {
                    setState(() {
                      selectedGender = answer!;
                    });
                  }
                ),
                Text('Female', style: TextStyle(fontSize: myFontSize)),
              ],
            ),
            const SizedBox(height: 12.0),
            Column(
              children: [
                Text('Notifications', style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.bold)),
                SwitchListTile(
                    title: Text('E-mail', style: TextStyle(fontSize: myFontSize)),
                    value: notifyEmail,
                    onChanged: (bool value) {
                      setState(() {
                        notifyEmail = value;
                      });
                    }
                ),
                SwitchListTile(
                    title: Text('Cellphone', style: TextStyle(fontSize: myFontSize),),
                    value: notifyCellphone,
                    onChanged: (bool value) {
                      setState(() {
                        notifyCellphone = value;
                      });
                    }
                )
              ],
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                _saveData();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
              ),
              child: Text('Register', style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Text("Font Size:", style: TextStyle(fontSize: myFontSize, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Slider(
                    value: myFontSize,
                    min: 14,
                    max: 22,
                    label: sliderLabel,
                    divisions: 8,
                    onChanged: (double newValue) {
                      setState(() {
                        myFontSize = newValue;
                        sliderLabel = "Font Size: $myFontSize";
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
