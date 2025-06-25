import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:media_blur_app/screens/standard_user/standart_user_bottom.dart';

import '../models/user.dart';
import '../providers/auth_service.dart';
import '../screens/admin/admin_bottom_nav.dart';
import '../screens/auth/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return const LoginScreen();
    }

    // Redirection basée sur le rôle
    switch (user.role) {
      case UserRole.admin:
        return const AdminDashboardScreen();
      case UserRole.standard:
        return const StandartUserBottom();
    }
  }
}