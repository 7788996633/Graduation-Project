import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../blocs/furlough_request_bloc/furlough_request_state.dart';
import '../../data/models/furlough_request_model.dart';
import 'furlough_item.dart';

class FurloughRequestList extends StatefulWidget {
  const FurloughRequestList({super.key, required this.bloc});
  final FurloughRequestsBloc bloc;

  @override
  State<FurloughRequestList> createState() => _FurloughRequestListState();
}

class _FurloughRequestListState extends State<FurloughRequestList> {
  @override
  void initState() {
    widget.bloc.add(GetAllFurloughRequests());
    super.initState();
  }

  List<FurloughRequestModel> furloughRequestList = [];

  Widget buildFurloughRequestModel() {
    return ListView.builder(
      itemCount: furloughRequestList.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) => FurloughRequestItem(
        furloughModel: furloughRequestList[index],
      ),
    );
  }

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
          BlocProvider.of<FurloughRequestsBloc>(context).add(GetAllFurloughRequests());
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
            return furloughRequestList.isEmpty
                ? const Text('There are no furlough requests')
                : buildFurloughRequestModel();
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
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
