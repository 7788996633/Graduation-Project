import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../blocs/furlough_request_bloc/furlough_request_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/furlough_list.dart';
import '../../widgets/refresh_button.dart';


import 'add_furlough_screen.dart';


class ListFurloughsScreen extends StatefulWidget {
  const ListFurloughsScreen({super.key});


  @override
  State<ListFurloughsScreen> createState() => _ListFurloughsScreenState();
}

class _ListFurloughsScreenState extends State<ListFurloughsScreen> {
  late FurloughRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<FurloughRequestsBloc>(context);
    bloc.add(
      GetAllFurloughRequests(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'list_furloughs',

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            FurloughRequestList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(
            GetAllFurloughRequests(),
          );
        },
      ),
    );
  }
}