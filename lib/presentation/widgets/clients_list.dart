import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_profile_bloc/user_profile_bloc.dart';
import '../../data/models/user_model.dart';
import 'user_checkbox_item.dart';
class ClientsList extends StatefulWidget {
  final Function(int)? onUserSelected;

  const ClientsList({super.key, this.onUserSelected});

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
  List<UserModel> clientsList = [];
  int? selectedUserId;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(GetAllClients());
  }

  Widget buildUserList() {
    return ListView.builder(
      itemCount: clientsList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final user = clientsList[index];
        return BlocProvider(
          create: (context) => UserProfileBloc(),
          child: UserCheckboxItem(
            userModel: user,
            selected: selectedUserId == user.id,
            onChanged: (checked) {
              setState(() {
                selectedUserId = checked == true ? user.id : null;
              });
              if (selectedUserId != null) {
                widget.onUserSelected?.call(selectedUserId!);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          BlocProvider.of<UserBloc>(context).add(GetAllUsers());
        } else if (state is UserFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errmsg, style: const TextStyle(fontSize: 16)),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UsersListLoaded) {
            clientsList = state.usersList;
            return clientsList.isEmpty
                ? const Center(child: Text('There are no users'))
                : buildUserList();
          } else if (state is UserFail) {
            return Column(
              children: [
                const Text("There is an error:", style: TextStyle(fontSize: 30)),
                Text(state.errmsg, style: const TextStyle(fontSize: 30)),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
