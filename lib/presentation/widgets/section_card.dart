import 'package:flutter/material.dart';
import '../../../../themes.dart';

class SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2 - 18,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: isLight.value ? 0 : 1),
          borderRadius: BorderRadius.circular(16),
        ),
        color: getCurrentTheme()['HomeCards'],
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: getCurrentTheme()['HomeCardsIcons'],
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: getCurrentTheme()['HomeCardsText'],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
