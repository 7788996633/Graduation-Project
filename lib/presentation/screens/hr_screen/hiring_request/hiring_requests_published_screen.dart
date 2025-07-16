import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../../../themes.dart';
import '../../../widgets/hiring_request_publish_list.dart';
import '../../../widgets/refresh_button.dart';

class ListHiringRequestsPublishScreen extends StatefulWidget {
  const ListHiringRequestsPublishScreen({super.key});

  @override
  State<ListHiringRequestsPublishScreen> createState() => _ListHiringRequestsPublishScreenState();
}

class _ListHiringRequestsPublishScreenState extends State<ListHiringRequestsPublishScreen> {
  late HiringRequestsBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HiringRequestsBloc>(context);
    bloc.add(GetHiringRequestsPublished());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            HiringRequestPublishList(bloc: bloc),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(GetHiringRequestsPublished());
        },
      ),
    );
  }
}
