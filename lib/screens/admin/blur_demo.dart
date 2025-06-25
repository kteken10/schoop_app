import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class BlurDemoScreen extends StatelessWidget {
  const BlurDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Toggle pour activer/désactiver le flou
          SwitchListTile(
            title: const Text('Enable Blur Effect'),
            subtitle: const Text('Toggle to activate media blurring'),
            value: true,
            onChanged: (value) {},
            activeColor: AppColors.primary,
          ),
          
          const SizedBox(height: 30),
          
          // Placeholder pour la démo visuelle
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Blur Effect Preview Area',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Section permissions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Required Permissions',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  _buildPermissionRow('Accessibility Service', true),
                  _buildPermissionRow('Display Over Other Apps', false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionRow(String permission, bool isGranted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            isGranted ? Icons.check_circle : Icons.error,
            color: isGranted ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 10),
          Text(permission),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child: Text(
              isGranted ? 'GRANTED' : 'REQUEST',
              style: TextStyle(
                color: isGranted ? Colors.grey : AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}