import 'package:flutter/material.dart';
import 'package:olupay/screens/home/dashboard_screen.dart';

import '../../service/auth_service.dart';
import '../../service/firestore_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = AuthService();
  final _db = FirestoreService();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(child: Text("Time after Time")),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "username cannot be empty";
                    }
                  },
                  controller: _nameController,
                  decoration: const InputDecoration(
                    label: Text('Username'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "email cannot be empty";
                    }
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return "Password cannot be empty";
                    }
                  },
                  controller: _passController,
                  decoration: const InputDecoration(label: Text('Password')),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Map<String, dynamic> userDataMap = {
                      "username": _nameController.text.toLowerCase().trim(),
                      "email": _emailController.text.toLowerCase().trim(),
                      "balance": 0,
                    };

                    await _auth
                        .createAccount(_emailController.text, _passController.text)
                        .then((val) => {
                              _db
                                  .saveUserDetails(userDataMap, val, context)
                                  .then((value) => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => DashboardScreen(
                                                    userid: value)))
                                      })
                            });
                  }
                },
                child: const Text("Create Account"),
              ),
              TextButton(onPressed: () {}, child: const Text("Sign in"))
            ],
          ),
        ),
      ),
    );
  }
}
