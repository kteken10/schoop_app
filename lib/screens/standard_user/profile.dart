import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../models/user.dart';
import '../../providers/auth_service.dart';
import '../../ui/profile_info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser!;

    return Scaffold(
      backgroundColor: AppColors.background,
     
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.secondary.withOpacity(0.1),
                child: Text(
                  user.initials,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                user.email,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Chip(
                label: Text(
                  user.roleDisplay,
                  style: TextStyle(
                    color: user.role == UserRole.admin
                        ? Colors.white
                        : AppColors.secondary,
                  ),
                ),
                backgroundColor: user.role == UserRole.admin
                    ? AppColors.secondary
                    : AppColors.secondary.withOpacity(0.1),
                shape: StadiumBorder(
                  side: BorderSide(
                    color: AppColors.secondary.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Carte d'abonnement
            ProfileInfoCard(
              icon: Icons.workspace_premium,
              title: "Abonnement",
              infos: [
                InfoItem(
                  label: "Statut",
                  value: user.hasPremiumFeatures
                      ? "Premium - Actif"
                      : "Gratuit - Fonctionnalités limitées",
                ),
                InfoItem(
                  label: "Avantages",
                  value: user.hasPremiumFeatures
                      ? "Toutes fonctionnalités débloquées"
                      : "Accès limité aux fonctionnalités",
                ),
              ],
              trailing: !user.hasPremiumFeatures
                  ? ElevatedButton(
                      onPressed: () {}, // TODO: Upgrade to premium
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: const Text(
                        'UPGRADE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),

            const SizedBox(height: 20),

            // Informations du compte
            ProfileInfoCard(
              icon: Icons.account_circle,
              title: "Informations du compte",
              infos: [
                InfoItem(
                  label: "Statut",
                  value: user.isActive ? "Actif" : "Inactif",
                ),
                InfoItem(
                  label: "Date de création",
                  value:
                      '${user.createdAt.day.toString().padLeft(2, '0')}/'
                      '${user.createdAt.month.toString().padLeft(2, '0')}/'
                      '${user.createdAt.year}',
                ),
                if (user.role == UserRole.admin)
                  InfoItem(
                    label: "Privilèges",
                    value: "Accès administrateur complet",
                  ),
              ],
            ),

            const SizedBox(height: 30),

            // Boutons d'action
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _editProfile(context),
                    
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Modifier",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _logout(context, authService),
                    icon: Icon(Icons.logout, color: AppColors.secondary),
                    label: Text(
                      "Déconnexion",
                      style: TextStyle(color: AppColors.secondary),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(
                            color: AppColors.secondary.withOpacity(0.3)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editProfile(BuildContext context) {
    // TODO: Implémenter la modification de profil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Modification du profil - À implémenter'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _logout(BuildContext context, AuthService authService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Déconnexion'),
        content: const Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              authService.logout();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text(
              'Déconnexion',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showSettings(BuildContext context) {
    // TODO: Implémenter les paramètres
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Paramètres - À implémenter'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}