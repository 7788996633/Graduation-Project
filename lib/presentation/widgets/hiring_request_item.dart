import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/hiring_requests/hiring_requests_block.dart';
import '../../blocs/hiring_requests/hiring_requests_event.dart';
import '../../constant.dart';
import '../../data/models/hiring_request_model.dart';
import '../../themes.dart';
import '../screens/hr_screen/hiring_request/hiring_request_detials.dart';

class HiringRequestItem extends StatelessWidget {
  const HiringRequestItem({super.key, required this.hiringRequestModel});
  final HiringRequestModel hiringRequestModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HiringRequestDetailsScreen(
                hiringRequestModel: hiringRequestModel,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(color: AppColors.darkBlue.withOpacity(0.6), width: 1.2),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            leading: CircleAvatar(
              radius: 26,
              backgroundColor: AppColors.darkBlue.withOpacity(0.1),
              child: const Icon(
                Icons.campaign_outlined,
                color: AppColors.darkBlue,
                size: 26,
              ),
            ),
            title: Text(
              hiringRequestModel.jopTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.darkBlue,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  const Text(
                    'Type: ',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      hiringRequestModel.type ?? 'N/A',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBlue,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            trailing: SizedBox(
              width: 100, // حجم مناسب لتجنب overflow
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
              if (myRole != null &&
              (myRole.toLowerCase() == 'hr'))
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                    onPressed: () {
                      BlocProvider.of<HiringRequestsBloc>(context).add(
                        DeleteHiringRequest(hiringRequestId: hiringRequestModel.id),
                      );
                    },
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.darkBlue,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
