import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/user_profile_bloc/user_profile_bloc.dart';

import '../../themes.dart';
import '../screens/settings/setting_screen.dart';
import '../screens/user_screens/user_profile_screens/create_user_profile_screen.dart';
import '../screens/user_screens/user_profile_screens/user_profile_screen.dart';


class CustomAppDrawer extends StatelessWidget {
  const CustomAppDrawer({super.key});

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
                      content: Text('No profile found: ${state.errmsg}'),
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
                              userProfileModel: userProfileModel,
                            ),
                          ),
                        ),
                      );
                    },
                    child: UserAccountsDrawerHeader(
                      decoration: const BoxDecoration(color: AppColors.darkBlue),
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
                                  create: (_) => UserProfileBloc(),
                                  child: const CreateUserProfileScreen(),
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
