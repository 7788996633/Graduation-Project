import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/furlough_request_bloc/furlough_request_bloc.dart';
import '../../blocs/furlough_request_bloc/furlough_request_event.dart';
import '../../data/models/furlough_request_model.dart';

import '../screens/furloughs/furlough_detials_screen.dart';

class FurloughRequestItem extends StatelessWidget {
  const FurloughRequestItem({super.key, required this.furloughModel});
  final FurloughRequestModel furloughModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FurloughDetailsScreen(
                furloughModel: furloughModel,
              ),
            ),
          );
        },
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<FurloughRequestsBloc>(context).add(
              DeleteFurloughRequestsEvent(furloughRequestId: furloughModel.id),
            );
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
        title: Text("ID: ${furloughModel.id}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cause: ${furloughModel.cause}"),
            Text("Status: ${furloughModel.status}"),
          ],
        ),
      ),
    );
  }
}
