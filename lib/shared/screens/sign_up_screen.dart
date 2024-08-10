import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';
import '../widgets/basic_app_button.dart';
import '../widgets/main_title.dart';
import '../widgets/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'user'; // Default role is 'user'
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //MainTitle
              const MainTitle(title: "Register"),
              const SizedBox(height: 40),
              //email field

              TextFieldWidget(hintText: "Email", controller: _emailController),
              const SizedBox(height: 30),
              //password field

              TextFieldWidget(
                hintText: "Password",
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 30),

              //select role

              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: const [
                  DropdownMenuItem(value: 'admin', child: Text('Admin')),
                  DropdownMenuItem(value: 'user', child: Text('User')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: const EdgeInsets.all(20),
                  hintStyle: const TextStyle(
                    color: Color(0xff383838),
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.4),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 0.4),
                  ),
                  hintText: "Select Role",
                ),
              ),

              const SizedBox(height: 40),
              //signup button

              BasicAppButton(
                onpressed: () async {
                  User? user = await _authService.signUp(_emailController.text,
                      _passwordController.text, _selectedRole);
                  if (user != null) {
                    // Navigate based on role
                    if (_selectedRole == 'admin') {
                      Navigator.pushNamed(context, '/admin');
                    } else {
                      Navigator.pushNamed(context, '/user');
                    }
                  }
                },
                title: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _signInText(),
    );
  }
}

class _signInText extends StatelessWidget {
  const _signInText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Do You have an account?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signin');
          },
          child: const Text("Sign in"),
        ),
      ],
    );
  }
}
