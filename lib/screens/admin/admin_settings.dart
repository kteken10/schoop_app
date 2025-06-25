import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Section logs
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'System Logs',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  _buildLogEntry('Blur service started', '2 min ago'),
                  _buildLogEntry('User login detected', '5 min ago'),
                  _buildLogEntry('Permission granted', '10 min ago'),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section paramètres
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Enable Notifications'),
                    value: true,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                  ),
                  const Divider(),
                  SwitchListTile(
                    title: const Text('Performance Monitoring'),
                    subtitle: const Text('Track blur processing metrics'),
                    value: false,
                    onChanged: (value) {},
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEntry(String message, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(message)),
          Text(
            time,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}