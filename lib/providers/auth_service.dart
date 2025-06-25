import 'package:flutter/material.dart';
import 'package:media_blur_app/models/user.dart';

class AuthService extends ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  // Mock login avec données locales améliorées
  Future<void> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simule un appel réseau
    
    // Utilisateurs de test plus réalistes
    final mockUsers = {
      'admin@standard.com': UserModel(
        id: 'admin_001',
        email: 'admin@standard.com',
        firstName: 'Alexandre',
        lastName: 'Dupont',
        role: UserRole.admin,
        isSubscribed: true,
      ),
     
      'user@standard.com': UserModel(
        id: 'user_003',
        email: 'user@standard.com',
        firstName: 'Thomas',
        lastName: 'Bernard',
        role: UserRole.standard,
        isSubscribed: false,
      ),
      'premium@standard.com': UserModel(
        id: 'premium_004',
        email: 'premium@standard.com',
        firstName: 'Emma',
        lastName: 'Petit',
        role: UserRole.standard,
        isSubscribed: true,
      ),
    };

    if (mockUsers.containsKey(email.toLowerCase())) {
      if (password == '12345678') { // Mot de passe plus sécurisé pour la démo
        _currentUser = mockUsers[email.toLowerCase()];
        notifyListeners();
        return;
      } else {
        throw Exception('Mot de passe incorrect');
      }
    }

    throw Exception('Utilisateur non trouvé');
  }

  // Mock pour l'inscription avec validation améliorée
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    bool isAdmin = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    // Validation du mot de passe
    if (password.length < 8) {
      throw Exception('Le mot de passe doit contenir au moins 8 caractères');
    }

    _currentUser = UserModel(
      id: 'new_${DateTime.now().millisecondsSinceEpoch}',
      email: email.toLowerCase(),
      firstName: firstName,
      lastName: lastName,
      role: isAdmin ? UserRole.admin : UserRole.standard,
      isSubscribed: false,
    );
    
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Mock pour la mise à jour du profil avec validation
  Future<void> updateProfile({
    String? firstName,
    String? lastName,
  }) async {
    if (_currentUser == null) {
      throw Exception('Utilisateur non connecté');
    }

    if (firstName != null && firstName.isEmpty) {
      throw Exception('Le prénom ne peut pas être vide');
    }

    if (lastName != null && lastName.isEmpty) {
      throw Exception('Le nom ne peut pas être vide');
    }

    _currentUser = _currentUser!.copyWith(
      firstName: firstName,
      lastName: lastName,
    );
    
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  // Vérifie si l'email est disponible avec plus de réalisme
  Future<bool> isEmailAvailable(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final takenEmails = {
      'admin@standard.com',
      'manager@standard.com',
      'user@standard.com',
      'premium@standard.com',
    };

    // Validation basique de l'email
    if (!email.contains('@') || !email.contains('.')) {
      throw Exception('Format d\'email invalide');
    }

    return !takenEmails.contains(email.toLowerCase());
  }

  // Nouvelle méthode pour changer le mot de passe
  Future<void> changePassword(String oldPassword, String newPassword) async {
    if (_currentUser == null) {
      throw Exception('Utilisateur non connecté');
    }

    if (newPassword.length < 8) {
      throw Exception('Le nouveau mot de passe doit contenir au moins 8 caractères');
    }

    await Future.delayed(const Duration(seconds: 1));
    // Dans une vraie app, on mettrait à jour le mot de passe côté serveur
  }
}

extension UserModelCopyWith on UserModel {
  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    bool? isSubscribed,
    bool? isActive,
    UserRole? role,
  }) {
    return UserModel(
      id: id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      isSubscribed: isSubscribed ?? this.isSubscribed,
      createdAt: createdAt,
      isActive: isActive ?? this.isActive,
    );
  }
}