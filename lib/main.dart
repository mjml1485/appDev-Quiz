import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false, // Removes the debug banner
  ));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isAuthenticated = false;

  void _login() {
    setState(() {
      if (_usernameController.text == 'user' && _passwordController.text == 'password') {
        _isAuthenticated = true;
      } else {
        _isAuthenticated = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid credentials')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isAuthenticated
          ? MyCV()
          : Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.greenAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // background color
                      foregroundColor: Colors.white, // text color
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyCV extends StatefulWidget {
  const MyCV({super.key});

  @override
  _MyCVState createState() => _MyCVState();
}

class _MyCVState extends State<MyCV> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My CV',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Center(
                child: Text(
                  'CV Sections',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.circle, color: Colors.grey, size: 10),
              title: const Text('Education'),
              onTap: () {
                Navigator.pop(context);
                _showDialog(
                    'Education',
                    'Tertiary: Batangas State University- The National Engineering University\n'
                        'Secondary: STI College Batangas, Talumpok Integrated School\n'
                        'Primary: Talumpok East Elementary School');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.circle, color: Colors.grey, size: 10),
              title: const Text('Skills'),
              onTap: () {
                Navigator.pop(context);
                _showDialog('Skills', 'Curiosity');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.circle, color: Colors.grey, size: 10),
              title: const Text('Projects'),
              onTap: () {
                Navigator.pop(context);
                _showDialog('Projects', 'None');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.circle, color: Colors.grey, size: 10),
              title: const Text('Experience'),
              onTap: () {
                Navigator.pop(context);
                _showDialog('Experience', 'None');
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 228, 225, 225),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.teal, width: 4),
                  ),
                  child: ClipOval(
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : const Image(
                      image: AssetImage('assets/lontok.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Personal Info
            const Text(
              'Mara Joy Lontok',
              style: TextStyle(fontSize: 29),
            ),
            const Text(
              '0905-591-1554',
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              '22-02744@g.batstate-u.edu.ph',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 246, 246),
                border: Border.all(color: Colors.black),
              ),
              child: const Text(
                'Professional goals\nTo Master Coding Languages and be a good developer',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
