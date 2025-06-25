enum UserRole { admin, standard }

class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final UserRole role;
  final bool isSubscribed;
  final DateTime createdAt;
  final bool isActive;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.isSubscribed = false,
    DateTime? createdAt,
    this.isActive = true,
  }) : createdAt = createdAt ?? DateTime.now();

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 'demo_${DateTime.now().millisecondsSinceEpoch}',
      email: map['email'] ?? 'demo@mediablur.app',
      firstName: map['firstName'] ?? 'Prénom',
      lastName: map['lastName'] ?? 'Nom',
      role: map['role'] == 'admin' ? UserRole.admin : UserRole.standard,
      isSubscribed: map['isSubscribed'] ?? false,
      isActive: map['isActive'] ?? true,
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'role': role.name,
      'isSubscribed': isSubscribed,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // ============ PROPRIÉTÉS CALCULÉES ============

  String get fullName => '$firstName $lastName';

  String get roleDisplay =>
      role == UserRole.admin ? 'Administrateur' : 'Utilisateur';

  String get initials =>
      firstName.isNotEmpty && lastName.isNotEmpty
          ? '${firstName[0]}${lastName[0]}'.toUpperCase()
          : '??';

  // ============ MÉTHODES MÉTIER ============

  bool get canToggleBlur => isActive;

  bool get canAccessAdminPanel => role == UserRole.admin;

  bool get hasPremiumFeatures => isSubscribed || role == UserRole.admin;

  // ============ MÉTHODES UTILITAIRES ============

  Map<String, dynamic> toDemoSummary() {
    return {
      'userType': role.name,
      'fullName': fullName,
      'hasPremium': hasPremiumFeatures,
      'status': isActive ? 'active' : 'inactive',
    };
  }

  @override
  String toString() => 'UserModel($fullName, $email, ${role.name})';
}
