import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../../../blocs/hiring_requests/hiring_requests_state.dart';

import '../../../../themes.dart';
import '../../../../constant.dart';
import '../../../../data/models/hiring_request_model.dart';

import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/hiring_request_item.dart';

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

  Future<void> _onRefresh() async {
    bloc.add(GetAllHiringRequests());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Hiring Requests',
        actionIcon: (myRole != null &&
            (myRole.toLowerCase() == 'admin' || myRole.toLowerCase() == 'hr'))
            ? Icons.add_circle_rounded
            : null,
        tooltip: 'Add New Hiring Request',
        onActionPressed: () {
          if (myRole != null &&
              (myRole.toLowerCase() == 'admin' || myRole.toLowerCase() == 'hr')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => HiringRequestsBloc(),
                  child: const AddHiringRequestScreen(),
                ),
              ),
            );
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<HiringRequestsBloc, HiringRequestsState>(
            builder: (context, state) {
              if (state is HiringRequestsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HiringRequestsFail) {
                return Center(child: Text(state.errmsg));
              } else if (state is HiringRequestsListLoaded) {
                final List<HiringRequestModel> requests = state.hiringRequestsList;
                if (requests.isEmpty) {
                  return const Center(child: Text('No Hiring Requests Available'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return HiringRequestItem(hiringRequestModel: requests[index]);
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
