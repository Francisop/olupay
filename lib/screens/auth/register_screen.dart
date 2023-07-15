import 'package:flutter/material.dart';

import '../../service/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = AuthService();
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
                    label: Text('Name'),
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
                onPressed: () {},
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
