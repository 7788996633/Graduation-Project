import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/my_furlough_list.dart';
import '../../widgets/refresh_button.dart';

class MyListFurloughRequestsScreen extends StatefulWidget {
  const MyListFurloughRequestsScreen({super.key});

  @override
  State<MyListFurloughRequestsScreen> createState() => _MyListFurloughRequestsScreenState();
}

class _MyListFurloughRequestsScreenState extends State<MyListFurloughRequestsScreen> {
  late FurloughRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<FurloughRequestsBloc>(context);
    bloc.add(GetMyFurloughRequests());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'My Furlough Requests',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            MyFurloughRequestList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetMyFurloughRequests());
        },
      ),
    );
  }
}