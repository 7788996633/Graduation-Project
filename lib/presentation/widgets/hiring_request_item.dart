import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../data/models/hiring_request_model.dart';

import '../screens/hr_screen/hiring_request/hiring_request_detials.dart';


class HiringRequestItem extends StatelessWidget {
  const HiringRequestItem({super.key, required this.hiringRequestModel});
  final HiringRequestModel hiringRequestModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HiringRequestDetailsScreen(
                hiringRequestModel: hiringRequestModel,
              ),
            ),
          );
        },
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<HiringRequestsBloc>(context).add(
              DeleteHiringRequest(hiringRequestId: hiringRequestModel.id),
            );
          },
          icon: const Icon(Icons.delete, color: Colors.red),
        ),
        title: Text(
          "Request #${hiringRequestModel.id}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text("Date: ${hiringRequestModel.jopTitle}"),
            Text("type: ${hiringRequestModel.type}"),
            Text("Description: ${hiringRequestModel.description}"),
            Text("status: ${hiringRequestModel.status}"),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
