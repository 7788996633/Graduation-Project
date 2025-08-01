import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../../blocs/lawyer_bloc/lawyer_event.dart';

import '../../../../themes.dart';
import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/lawyer_list.dart';
import '../../../widgets/refresh_button.dart';

class ListLawyersScreen extends StatefulWidget {


  const ListLawyersScreen({
    super.key,

  });

  @override
  State<ListLawyersScreen> createState() => _ListLawyersScreenState();
}

class _ListLawyersScreenState extends State<ListLawyersScreen> {
  late LawyerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LawyerBloc>(context);
    bloc.add(GetAllLawyersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Lawyers',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            LawyerList(
            ),

          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllLawyersEvent());
        },
      ),
    );
  }
}
