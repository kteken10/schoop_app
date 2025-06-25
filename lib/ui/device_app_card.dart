import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import '../../constants/colors.dart';

class DeviceAppCard extends StatelessWidget {
  final AppInfo app;
  final bool isSystemApp;
  final VoidCallback? onTap;

  const DeviceAppCard({
    super.key,
    required this.app,
    required this.isSystemApp,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color:AppColors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: app.icon != null
                    ? Image.memory(app.icon!, width: 40, height: 40)
                    : const Icon(Icons.apps, size: 30, color: AppColors.primary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.textprimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      app.packageName,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textprimary.withOpacity(0.6),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSystemApp
                            ? Colors.red.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        isSystemApp ? 'Système' : 'Utilisateur',
                        style: TextStyle(
                          fontSize: 10,
                          color: isSystemApp ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.launch, size: 20),
                onPressed: onTap,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}