import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class BlurSettingsScreen extends StatelessWidget {
  const BlurSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
      
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildPermissionTile(
            icon: Icons.accessibility,
            title: "Permission d'accessibilité",
            subtitle: "Nécessaire pour détecter le contenu",
          ),
          _buildPermissionTile(
            icon: Icons.layers,
            title: "Permission Overlay",
            subtitle: "Pour superposer l'effet de flou",
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.blur_circular),
            title: const Text("Intensité du flou"),
            subtitle: const Text("Niveau moyen (fixe pour la démo)"),
            trailing: const Text("50%"),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionTile({required IconData icon, required String title, required String subtitle}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.warning_amber_rounded, color: Colors.orange),
      onTap: () {}, // Ici vous intégrerez la demande de permission
    );
  }
}