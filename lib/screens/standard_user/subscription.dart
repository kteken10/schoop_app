import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background ,
      appBar: AppBar(title: const Text("Abonnement")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Votre plan actuel"),
            subtitle: const Text("Version Gratuite", style: TextStyle(color: Colors.red)),
            trailing: FilledButton(
              child: const Text("UPGRADE"),
              onPressed: () {}, // Intégrer l'achat
            ),
          ),
          const Divider(),
          ...['Flou illimité', 'Apps sélectionnables', 'Support prioritaire'].map(
            (feature) => ListTile(
              leading: const Icon(Icons.check_circle, color: AppColors.secondary),
              title: Text(feature),
            ),
          ),
        ],
      ),
    );
  }
}