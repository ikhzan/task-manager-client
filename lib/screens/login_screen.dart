
import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';
import 'package:task_manager_client/screens/main_screen.dart';
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
      await LocalStorage.setUserLoggedIn(true);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login failed!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 80),
              SizedBox(height: 20,),

              Column(
                    children: [
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: "Username", 
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10)
                          ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Password", 
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder()
                        ),
                        obscureText: true
                      ),
                      SizedBox(height: 20,),
                      _isLoading ?
                        CircularProgressIndicator()
                        : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                          ),
                          onPressed: _handleLogin, 
                          child: SizedBox(
                            width: double.infinity,
                            child: Center(child: Text("Log In", style: TextStyle(fontSize: 18),),),
                          )
                        )
                    ],
                  ),
            ],
          ),
        ),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(title: Text("Login")),
    //   body: Padding(
    //     padding: EdgeInsets.all(16.0),
    //     child: Column(
    //       children: [
    //         TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Username")),
    //         SizedBox(height: 10),
    //         TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
    //         SizedBox(height: 20),
    //         _isLoading ? CircularProgressIndicator() : ElevatedButton(onPressed: _handleLogin, child: Text("Login")),
    //       ],
    //     ),
    //   ),
    // );
  }
}