import 'package:flutter/material.dart';
import '../services/auth/auth_service.dart';

class NavbarWidget extends StatelessWidget {
  final String title;

  NavbarWidget({
    super.key,
    required this.title,
  });

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () async {
            await _authService.signOut();
            Navigator.pushReplacementNamed(context, '/signin');
          },
        ),
      ],
    );
  }
}
