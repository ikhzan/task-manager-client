
import 'package:flutter/material.dart';
import 'package:task_manager_client/screens/home_screen.dart';
import 'package:task_manager_client/services/auth_service.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() => _isLoading = true);
    final success = await _authService.login(_usernameController.text, _passwordController.text);
    setState(() => _isLoading = false);

    if (success) {
      Navigator.pushReplacementNamed(context, '/tasks'); // Redirect to Task List
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Username")),
            SizedBox(height: 10),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            SizedBox(height: 20),
            _isLoading ? CircularProgressIndicator() : ElevatedButton(onPressed: _handleLogin, child: Text("Login")),
          ],
        ),
      ),
    );
  }
}