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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x11000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: const EdgeInsets.all(20),
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
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.red.withOpacity(0.1),
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              BlocProvider.of<HiringRequestsBloc>(context).add(
                DeleteHiringRequest(hiringRequestId: hiringRequestModel.id),
              );
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            hiringRequestModel.jopTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.work_outline, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "Type: ${hiringRequestModel.type}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.check_circle_outline, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "Status: ${hiringRequestModel.status}",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      ),
    );
  }
}
