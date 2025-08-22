import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../blocs/hiring_requests/hiring_requests_state.dart';

import '../../data/models/hiring_request_model.dart';
import 'hiring_request_item.dart';


class HiringRequestPublishList extends StatefulWidget {
  const HiringRequestPublishList({super.key, required this.bloc});
  final HiringRequestsBloc bloc;

  @override
  State<HiringRequestPublishList> createState() => _HiringRequestPublishListState();
}

class _HiringRequestPublishListState extends State<HiringRequestPublishList> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(GetHiringRequestsPublished());
  }

  List<HiringRequestModel> hiringRequestList = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<HiringRequestsBloc, HiringRequestsState>(
      listener: (context, state) {
        if (state is HiringRequestsSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.successmsg,
                style: const TextStyle(fontSize: 16),
              ),
              backgroundColor: Colors.green,
            ),
          );
          widget.bloc.add(GetHiringRequestsPublished());
        } else if (state is HiringRequestsFail) {
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
      child: BlocBuilder<HiringRequestsBloc, HiringRequestsState>(
        builder: (context, state) {
          if (state is HiringRequestsListLoaded) {
            hiringRequestList = state.hiringRequestsList;
            if (hiringRequestList.isEmpty) {
              return const Center(child: Text('There are no hiring requests.'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: hiringRequestList.length,
                itemBuilder: (context, index) {
                  return HiringRequestItem(
                    hiringRequestModel: hiringRequestList[index],
                  );
                },
              ),
            );
          } else if (state is HiringRequestsFail) {
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
