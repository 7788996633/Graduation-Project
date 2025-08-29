import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../../../blocs/furlough_request_bloc/furlough_request_state.dart';

import '../../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/furlough_item.dart';
import '../../widgets/my_furlough_list.dart';

class MyListFurloughRequestsScreen extends StatefulWidget {
  const MyListFurloughRequestsScreen({super.key});

  @override
  State<MyListFurloughRequestsScreen> createState() =>
      _MyListFurloughRequestsScreenState();
}

class _MyListFurloughRequestsScreenState
    extends State<MyListFurloughRequestsScreen> {
  late FurloughRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<FurloughRequestsBloc>(context);
    bloc.add(GetMyFurloughRequests());
  }

  Future<void> _onRefresh() async {
    bloc.add(GetMyFurloughRequests());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: const CustomActionAppBar(
        title: 'My Furlough Requests',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<FurloughRequestsBloc, FurloughRequestsState>(
            builder: (context, state) {
              if (state is FurloughRequestsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FurloughRequestsFail) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(state.errmsg),
                      ),
                    ),
                  ],
                );
              } else if (state is FurloughRequestsListLoaded) {
                final furloughList = state.furloughRequestsList;
                if (furloughList.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('No Furlough Requests Available'),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: furloughList.length,
                  itemBuilder: (context, index) {
                    return FurloughRequestItem(
                      furloughModel: furloughList[index],
                    );
                  },
                );
              }
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
              );
            },
          ),
        ),
      ),
    );
  }
}
