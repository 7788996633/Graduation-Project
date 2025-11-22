import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../../../blocs/hiring_requests/hiring_requests_state.dart';

import '../../../../themes.dart';
import '../../../../data/models/hiring_request_model.dart';

import '../../../widgets/custom_appbar_add.dart';
import '../../../widgets/hiring_request_item.dart';


class ListHiringRequestsPublishScreen extends StatefulWidget {
  const ListHiringRequestsPublishScreen({super.key});

  @override
  State<ListHiringRequestsPublishScreen> createState() =>
      _ListHiringRequestsPublishScreenState();
}

class _ListHiringRequestsPublishScreenState
    extends State<ListHiringRequestsPublishScreen> {
  late HiringRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HiringRequestsBloc>(context);
    bloc.add(GetHiringRequestsPublished());
  }

  Future<void> _onRefresh() async {
    bloc.add(GetHiringRequestsPublished());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Hiring Requests Published',
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
                final List<HiringRequestModel> requests =
                    state.hiringRequestsList;
                if (requests.isEmpty) {
                  return const Center(
                      child: Text('No Published Hiring Requests'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return HiringRequestItem(
                        hiringRequestModel: requests[index]);
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
