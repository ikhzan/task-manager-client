import 'package:flutter/material.dart';
import 'package:task_manager_client/screens/main/main_screen.dart';
import 'package:task_manager_client/screens/auth/register_screen.dart';
import 'package:task_manager_client/services/auth_service.dart';
import 'package:task_manager_client/widgets/basic_app_bar.dart';

class LoginScreen extends StatefulWidget {
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
    final success = await _authService.login(
      _usernameController.text,
      _passwordController.text
    );
    setState(() => _isLoading = false);

    if (success) {
      //await LocalStorage.setUserLoggedIn(true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Login failed!")));
    }
  }

  Widget _usernameField(BuildContext context) {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: "Username",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      obscureText: true,
    );
  }

  Widget _signupText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not a member ?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => RegisterScreen(),
                ),
              );
            },
            child: Text('Register Now'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            color: Colors.deepPurpleAccent,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            _usernameField(context),
            SizedBox(height: 30),
            _passwordField(context),
            SizedBox(height: 30),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                    ),
                    onPressed: _handleLogin,
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("Log In", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: _signupText(),
    );
  }
}
