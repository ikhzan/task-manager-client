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
        prefixIcon: Icon(Icons.text_fields),
        border: OutlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        prefixIcon: Icon(Icons.mail_outline_outlined),
        border: OutlineInputBorder(),
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        errorText: _emailErrorText,
      ),
      onChanged: (value) {
        setState(() {
          _emailErrorText = _validateEmail(value)
              ? null
              : "Invalid email format";
        });
      },
    );
  }

  String? _emailErrorText;

  bool _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
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
    bool _obscureText = true;

    return StatefulBuilder(
      builder: (context, setState) {
        return TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: "Password",
            prefixIcon: Icon(Icons.fingerprint),
            border: OutlineInputBorder(),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            ),
          ),
          obscureText: _obscureText,
        );
      },
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
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Please register with your email and username',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                _fullNameField(context),
                SizedBox(height: 30),
                _emailField(context),
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
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 24,
                          ),
                        ),
                        onPressed: _handleRegister,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                "Create User",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _siginText(),
    );
  }
}
