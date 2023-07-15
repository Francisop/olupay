import 'package:flutter/material.dart';
import 'package:olupay/screens/auth/register_screen.dart';

import '../../service/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _formKey = GlobalKey<FormState>();
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
              Center(
                  child: Text("Welcome, sign in to continue to your account")),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.purple,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _auth.login(_emailController, _passController);
                    }
                  },
                  child: Text("Login"),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegisterScreen()));
                  },
                  child: const Text("Sign up"))
            ],
          ),
        ),
      ),
    );
  }
}
