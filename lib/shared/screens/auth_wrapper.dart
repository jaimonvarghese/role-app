import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../modules/admin_module/screens/admin_dashboard_screen.dart';
import '../../modules/user_module/screens/user_dashboard_screen.dart';
import '../services/auth/auth_service.dart';
import 'sign_in_screen.dart';


class AuthWrapper extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    User? user = _authService.getCurrentUser();

    if (user == null) {
      return SignInScreen();
    } else {
      return FutureBuilder<bool>(
        future: _authService.isAdmin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == true) {
            return AdminDashboardScreen();
          } else {
            return UserDashboardScreen();
          }
        },
      );
    }
  }
}
