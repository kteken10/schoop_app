import 'package:flutter/material.dart';

class BrandingCard extends StatelessWidget {
  final String imagePath;
  final bool withHorizontalMargin;

  const BrandingCard({
    super.key,
    required this.imagePath,
    this.withHorizontalMargin = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: withHorizontalMargin
          ? const EdgeInsets.symmetric(horizontal: 16)
          : EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image positionnée à gauche
              Container(
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Partie branding/text
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _FeatureTag(
                                icon: Icons.blur_on, text: 'Live blurring'),
                            const SizedBox(width: 8),
                            _FeatureTag(
                                icon: Icons.switch_right,
                                text: 'Instant toggle'),
                            const SizedBox(width: 8),
                            _FeatureTag(
                                icon: Icons.security, text: 'Privacy shield'),
                          ],
                        ),
                      ),
                      Text(
                        'Media Blur Protection',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Contrôle total de votre confidentialité visuelle',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureTag({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
