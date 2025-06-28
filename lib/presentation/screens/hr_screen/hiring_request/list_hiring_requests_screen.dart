import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';

import '../../../../constant.dart';

import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/hiring_requests_list.dart';
import '../../../widgets/refresh_button.dart';


import 'add_hiring_request_screen.dart';

class ListHiringRequestsScreen extends StatefulWidget {
  const ListHiringRequestsScreen({super.key});

  @override
  State<ListHiringRequestsScreen> createState() => _ListHiringRequestsScreenState();
}

class _ListHiringRequestsScreenState extends State<ListHiringRequestsScreen> {
  late HiringRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HiringRequestsBloc>(context);
    bloc.add(GetAllHiringRequests());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Hiring Requests',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Hiring Request',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => HiringRequestsBloc(),
                child: const AddHiringRequestScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            HiringRequestList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetAllHiringRequests());
        },
      ),
    );
  }
}
