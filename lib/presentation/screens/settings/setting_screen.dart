import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/blocs/company_info_bloc/company_info_bloc.dart';
import 'package:untitled5/presentation/screens/company_info_screen/company_info_details.dart';
import 'package:untitled5/data/models/company_info_model.dart';

import '../../../themes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool is2FAEnabled = false;
  final GlobalKey _languageKey = GlobalKey();

  void _showLanguageMenu() async {
    final RenderBox renderBox =
    _languageKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        position.dx + renderBox.size.width,
        position.dy,
      ),
      items: const [
        PopupMenuItem<String>(
          value: 'ar',
          child: Text('العربية'),
        ),
        PopupMenuItem<String>(
          value: 'en',
          child: Text('English'),
        ),
      ],
    );

    if (selected != null) {
      final locale = Locale(selected);
      await context.setLocale(locale);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('settings'),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: !isLight ? Colors.black : AppColors.darkBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildSectionTitle(tr('general')),
            _buildCard(
              icon: Icons.language,
              title: tr('change_language'),
              trailing: GestureDetector(
                key: _languageKey,
                onTap: _showLanguageMenu,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      context.locale.languageCode == 'ar' ? 'العربية' : 'English',
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            _buildCard(
              icon: Icons.brightness_6,
              title: tr('dark_mode'),
              trailing: Switch(
                value: !isLight,
                onChanged: (val) {
                  isLight = !isLight;
                  setState(() {});
                },
              ),
            ),
            _buildCard(
              icon: Icons.lock,
              title: tr('change_password'),
              onTap: () {},
            ),
            _buildCard(
              icon: Icons.logout,
              title: tr('logout'),
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(tr('company')),
            _buildCard(
              icon: Icons.business,
              title: tr('company_name_logo'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) => CompanyInfoBloc(),
                      child: CompanyInfoDetailsScreen(

                      ),
                    ),
                  ),
                );
              },
            ),
            _buildCard(
              icon: Icons.contact_mail,
              title: tr('official_contact_info'),
              onTap: () {},
            ),
            _buildCard(
              icon: Icons.info,
              title: tr('about_company'),
              onTap: () {},
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(tr('security')),
            _buildCard(
              icon: Icons.security,
              title: tr('two_factor_authentication'),
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
              title: tr('manage_active_sessions'),
              onTap: () {},
            ),
            _buildCard(
              icon: Icons.folder_shared,
              title: tr('folder_access_permissions'),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(icon, color: Colors.black, size: 28),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
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
