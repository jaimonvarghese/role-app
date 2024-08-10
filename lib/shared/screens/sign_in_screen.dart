import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:role_app/shared/widgets/basic_app_button.dart';
import 'package:role_app/shared/widgets/main_title.dart';
import 'package:role_app/shared/widgets/text_field_widget.dart';
import '../services/auth/auth_service.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              const MainTitle(title: "Sign In"),
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
              const SizedBox(height: 40),
              //signin button

              BasicAppButton(
                onpressed: () async {
                  try {
                    User? user = await _authService.signIn(
                        _emailController.text, _passwordController.text);

                    if (user != null) {
                      // Determine role and navigate
                      bool isAdmin = await _authService.isAdmin();
                      if (isAdmin) {
                        Navigator.pushNamed(context, '/admin');
                      } else {
                        Navigator.pushNamed(context, '/user');
                      }
                    }
                  } catch (e) {
                    // Display the error message in a SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                title: 'Sign In',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _signUpText(),
    );
  }
}

class _signUpText extends StatelessWidget {
  const _signUpText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an account?',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text("Sign up"))
      ],
    );
  }
}
