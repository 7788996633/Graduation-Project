import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';

import '../screens/lawyer_screens/lawyer_profile_screens/lawyer_profile_screen.dart';
import '../screens/settings/setting_screen.dart';

class CustomDrawerLawyer extends StatelessWidget {
  const CustomDrawerLawyer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            BlocConsumer<LawyerProfileBloc, LawyerProfileState>(
              listener: (context, state) {
                if (state is LawyerProfileFail) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('فشل تحميل الملف الشخصي: ${state.errmsg}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is LawyerProfileLoadedSuccessfully) {
                  final lawyerModel = state.lawyerModel;

                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (context) => LawyerProfileBloc(),
                            child: LawyerProfileScreen(
                              lawyerModel: lawyerModel,
                            ),
                          ),
                        ),
                      );
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: Color(0XFF472A0C)),
                      accountName: Text(lawyerModel.name),
                      accountEmail: Text(lawyerModel.email),
                      currentAccountPicture: CircleAvatar(
                        radius: 30,
                        backgroundImage: lawyerModel.image.isNotEmpty
                            ? NetworkImage(
                                '${lawyerModel.image}?v=${DateTime.now().millisecondsSinceEpoch}',
                              )
                            : const AssetImage('assets/default_image.png')
                                as ImageProvider,
                      ),
                    ),
                  );
                } else if (state is LawyerProfileFail) {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0XFF472A0C)),
                    child: Center(
                      child: Icon(Icons.error, color: Colors.white),
                    ),
                  );
                } else {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Color(0XFF472A0C)),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
