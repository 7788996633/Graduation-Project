import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../../../themes.dart';
import '../screens/settings/setting_screen.dart';
import '../screens/user_screens/user_profile_screens/user_profile_screen.dart';

class CustomAppDrawer extends StatefulWidget {

  final VoidCallback? onSettingsClosed;

  const CustomAppDrawer({super.key, this.onSettingsClosed});

  @override
  State<CustomAppDrawer> createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            BlocConsumer<UserProfileBloc, UserProfileState>(
              listener: (context, state) {
                if (state is UserProfileFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('فشل تحميل الملف الشخصي: ${state.errmsg}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is UserProfileLoadedSuccessfully) {
                  final userProfileModel = state.userProfileModel;
                  const File? pickedImage = null;

                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) => UserProfileBloc(),
                            child: UserProfileScreen(
                              userId: userProfileModel.userId,
                            ),
                          ),
                        ),
                      );
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: Color(0XFF472A0C)),
                      accountName: Text(userProfileModel.name),
                      accountEmail: Text(userProfileModel.email),
                      currentAccountPicture: CircleAvatar(
                        radius: 30,
                        backgroundImage: pickedImage != null
                            ? FileImage(pickedImage)
                            : (userProfileModel.image.isNotEmpty
                            ? NetworkImage(userProfileModel.image)
                            : const AssetImage('assets/default_image.png'))
                        as ImageProvider,
                      ),
                    ),
                  );
                } else if (state is UserProfileFail) {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0XFF472A0C)),
                    child: Center(
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                  );
                } else {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: AppColors.darkBlue),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(tr('settings')),
              onTap: () async {
                Navigator.pop(context); // غلق الدروير
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
                // بعد العودة من الإعدادات، ننادي الـ callback لإعادة بناء الشاشة الأب
                if (widget.onSettingsClosed != null) {
                  widget.onSettingsClosed!();
                }
                // مع ذلك، نعيد بناء الدروير لتحديث النصوص فيه أيضا
                setState(() {});
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title: Text(tr('logout')),
              onTap: () {
                Navigator.pop(context);
                // هنا يمكن تضيف وظيفة تسجيل الخروج
              },
            ),
          ],
        ),
      ),
    );
  }
}
