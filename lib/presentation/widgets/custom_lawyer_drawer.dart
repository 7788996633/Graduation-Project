import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/lawyer_profile_bloc/lawyer_profiel_bloc.dart';
import '../../themes.dart';
import '../screens/lawyer_screens/lawyer_profile_screens/lawyer_profile_screen.dart';
import '../screens/settings/setting_screen.dart';
import '../screens/lawyer_screens/lawyer_profile_screens/create_lawyer_profile_screen.dart';

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
                      content: Text('Failed to load profile: ${state.errmsg}'),
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
                            create: (_) => LawyerProfileBloc(),
                            child: LawyerProfileScreen(
                              lawyerModel: lawyerModel,
                            ),
                          ),
                        ),
                      );
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: AppColors.darkBlue),
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
                  return DrawerHeader(
                    decoration: const BoxDecoration(color: AppColors.darkBlue),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.white),
                        const SizedBox(height: 10),
                        const Text(
                          'No profile found',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => BlocProvider(
                                  create: (_) => LawyerProfileBloc(),
                                  child: const CreateLawyerProfileScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text('Create New Account'),
                        ),
                      ],
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
