import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTypeFilter extends StatelessWidget {
  final String? selectedType;
  final ValueChanged<String?> onTypeSelected;
  final EdgeInsetsGeometry? padding;

  const AppTypeFilter({
    super.key,
    this.selectedType,
    required this.onTypeSelected,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final types = ['Toutes', 'Système', 'Utilisateur'];
    
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Type d'applications :",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth,
                child: Row(
                  children: List.generate(types.length, (index) {
                    final type = types[index];
                    final isSelected = selectedType == type;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: index < types.length - 1 ? 8 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () => onTypeSelected(isSelected ? null : type),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withOpacity(0.2)
                                  : AppColors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected 
                                    ? AppColors.primary.withOpacity(0.2)
                                    : AppColors.white
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              type,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textprimary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}