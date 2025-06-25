import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Statistiques rapides
          Row(
            children: [
              _buildStatCard('Total Users', '142', Icons.people),
              const SizedBox(width: 10),
              _buildStatCard('Active Now', '23', Icons.person),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Liste des utilisateurs
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text('User ${index + 1}'),
                subtitle:  Text('user${index + 1}@mediablur.com'),
                trailing: Switch(
                  value: index % 2 == 0,
                  onChanged: (value) {},
                  activeColor: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.primary),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}