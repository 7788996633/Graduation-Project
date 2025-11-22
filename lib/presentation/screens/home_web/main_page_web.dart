import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String selectedLanguage = 'العربية';
  bool isDarkMode = false;

  // لإنشاء GlobalKey للزر
  final GlobalKey _languageKey = GlobalKey();

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
  }

  // دالة لعرض القائمة أسفل الزر
  void _showLanguageMenu(BuildContext context) async {
    final RenderBox renderBox = _languageKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero); // تحديد موقع الزر

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy + renderBox.size.height, position.dx + renderBox.size.width, position.dy),
      items: [
        const PopupMenuItem<String>(
          value: 'العربية',
          child: Text('العربية'),
        ),
        const PopupMenuItem<String>(
          value: 'الإنجليزية',
          child: Text('English'),
        ),
      ],
    ).then((selected) {
      if (selected != null) {
        selectLanguage(selected);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        backgroundColor: Colors.transparent, // تعيين اللون إلى شفاف
        elevation: 0, // إزالة الظل تحت الـ AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: 28, // تصغير حجم الأيقونة
            onPressed: () {
              // هنا تفتح صفحة الإشعارات أو تظهر رسالة
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('لا يوجد إشعارات جديدة')),
              );
            },
          ),
          ElevatedButton(
            key: _languageKey, // إعطاء الزر مفتاح فريد
            onPressed: () {
              // عند الضغط على الزر، سيتم عرض القائمة أسفله
              _showLanguageMenu(context);
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor: Colors.transparent, // اللون عند الضغط
              shadowColor: Colors.transparent, // إزالة الظل
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('تغيير اللغة - $selectedLanguage'),
          ),
          IconButton(
            icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
            iconSize: 28, // تصغير حجم الأيقونة
            onPressed: toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 28, // تصغير حجم الأيقونة
            onPressed: () {
              // ممكن تنقله لصفحة الإعدادات
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('فتح الإعدادات')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            iconSize: 28, // تصغير حجم الأيقونة
            onPressed: () {
              // تنفيذ تسجيل الخروج
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تسجيل الخروج')),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: Text(
          'مرحباً بك في الرئيسية!',
          style: TextStyle(
            fontSize: 24,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }
}
