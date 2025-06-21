import 'package:flutter/material.dart';

import '../../../constant.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'العربية';
  bool isDarkMode = false;
  bool is2FAEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: isDark ? Colors.black : AppColors.darkBlue,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSectionTitle('عام'),
            _buildCard(
              icon: Icons.language,
              title: 'تغيير اللغة',
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                underline: Container(),
                items: ['العربية', 'English'].map((lang) {
                  return DropdownMenuItem(
                    value: lang,
                    child: Text(lang),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedLanguage = value!;
                  });
                },
              ),
            ),
            _buildCard(
              icon: Icons.brightness_6,
              title: 'الوضع الليلي',
              trailing: Switch(
                value: isDarkMode,
                onChanged: (val) {
                  setState(() {
                    isDarkMode = val;
                  });
                },
              ),
            ),
            _buildCard(
              icon: Icons.lock,
              title: 'تغيير كلمة المرور',
              onTap: () {
                // شاشة تغيير كلمة المرور
              },
            ),
            _buildCard(
              icon: Icons.logout,
              title: 'تسجيل الخروج',
              onTap: () {
                // تسجيل الخروج
              },
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('الشركة'),
            _buildCard(
              icon: Icons.business,
              title: 'اسم وشعار الشركة',
              onTap: () {},
            ),
            _buildCard(
              icon: Icons.contact_mail,
              title: 'بيانات التواصل الرسمية',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('الأمان'),
            _buildCard(
              icon: Icons.security,
              title: 'التحقق بخطوتين',
              trailing: Switch(
                value: is2FAEnabled,
                onChanged: (val) {
                  setState(() {
                    is2FAEnabled = val;
                  });
                },
              ),
            ),
            _buildCard(
              icon: Icons.phonelink_lock,
              title: 'إدارة الجلسات النشطة',
              onTap: () {},
            ),
            _buildCard(
              icon: Icons.folder_shared,
              title: 'صلاحيات الوصول للمجلدات',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: Colors.black, size: 28),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600,color: Colors.black,)),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }
}
