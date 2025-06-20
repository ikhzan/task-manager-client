import 'package:flutter/material.dart';
import 'package:task_manager_client/screens/auth/login_screen.dart';
import 'package:task_manager_client/services/auth_service.dart';
import 'package:task_manager_client/widgets/basic_app_bar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleRegister() async {
    setState(() => _isLoading = true);
    final success = await _authService.register(
      _fullnameController.text,
      _usernameController.text,
      _passwordController.text,
      _emailController.text,
    );
    setState(() => _isLoading = false);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successfull, Please Login")),
      );
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed, Please Login")),
      );
    }
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullnameController,
      decoration: InputDecoration(
        labelText: "Fullname",
        prefixIcon: Icon(Icons.details),
        border: OutlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(Icons.mail_outline_outlined),
        border: OutlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _usernameField(BuildContext context) {
    return TextField(
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: "Username",
        prefixIcon: Icon(Icons.person_outline),
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
        prefixIcon: Icon(Icons.password),
        border: OutlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      obscureText: true,
    );
  }

  Widget _siginText() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Do you have an account ?',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginScreen(),
                ),
              );
            },
            child: Text('Login Now'),
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
          'Register',
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
            _fullNameField(context),
            SizedBox(height: 30),
            _emailField(context),
            SizedBox(height: 30),
            _usernameField(context),
            SizedBox(height: 30),
            _passwordField(context),
            SizedBox(height: 40),
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
                    onPressed: _handleRegister,
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text("Create User", style: TextStyle(fontSize: 18)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: _siginText(),
    );
  }
}
