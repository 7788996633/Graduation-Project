import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/delegations_bloc/delegations_bloc.dart';
import '../../../blocs/delegations_bloc/delegations_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/delegation_list.dart';
import '../../widgets/refresh_button.dart';

class ListDelegationsScreen extends StatefulWidget {
  const ListDelegationsScreen({super.key});

  @override
  State<ListDelegationsScreen> createState() => _ListDelegationsScreenState();
}

class _ListDelegationsScreenState extends State<ListDelegationsScreen> {
  late DelegationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DelegationBloc>(context);
    bloc.add(GetAllDelegationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List_Delegations',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            DelegationList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllDelegationsEvent());
        },
      ),
    );
  }
}