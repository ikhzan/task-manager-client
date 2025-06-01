
import 'package:flutter/material.dart';
import 'package:task_manager_client/services/auth_service.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
 _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _handleRegister() async {
    setState(() => _isLoading = true);
    final success = await _authService.register(_usernameController.text, _passwordController.text);
    setState(() => _isLoading = false);
    if(success){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Successfull, Please Login")));
      Navigator.pushReplacementNamed(context, '/login');
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Registration Failed, Please Login")));
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Register"),),
      body: Padding(padding: EdgeInsets.all(16.0), child: Column(
        children: [
          TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Username"),),
          SizedBox(height: 10,),
          TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"),),
          SizedBox(height: 10,),
          _isLoading ? CircularProgressIndicator() : ElevatedButton(onPressed: _handleRegister, child: Text("Sign Up")),         
        ],
      ),),
    );
  }
}