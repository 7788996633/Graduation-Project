import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/furlough_request_bloc/furlough_request_bloc.dart';

import '../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../blocs/furlough_request_bloc/furlough_request_state.dart';

import '../../data/models/furlough_request_model.dart';
import 'furlough_item.dart';

class MyFurloughRequestList extends StatefulWidget {
  const MyFurloughRequestList({super.key, required this.bloc});
  final FurloughRequestsBloc bloc;

  @override
  State<MyFurloughRequestList> createState() => _MyFurloughRequestListState();
}

class _MyFurloughRequestListState extends State<MyFurloughRequestList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetMyFurloughRequests());
  }

  List<FurloughRequestModel> furloughRequestList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<FurloughRequestsBloc, FurloughRequestsState>(
      listener: (context, state) {
        if (state is FurloughRequestsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetMyFurloughRequests());
        } else if (state is FurloughRequestsFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<FurloughRequestsBloc, FurloughRequestsState>(
        builder: (context, state) {
          if (state is FurloughRequestsListLoaded) {
            furloughRequestList = state.furloughRequestsList;
            if (furloughRequestList.isEmpty) {
              return const Center(child: Text('There are no furlough requests'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: furloughRequestList.length,
                itemBuilder: (context, index) {
                  return FurloughRequestItem(
                    furloughModel: furloughRequestList[index],
                  );
                },
              ),
            );
          } else if (state is FurloughRequestsFail) {
            return Column(
              children: [
                const Text(
                  "There is an error:",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  state.errmsg,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
