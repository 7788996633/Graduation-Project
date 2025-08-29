import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../data/models/session_appointement_model.dart';
import '../../responsive.dart';
import '../../themes.dart';

class SessionAppointmentItem extends StatelessWidget {
  const SessionAppointmentItem(
      {super.key, required this.sessionAppointementModel});
  final SessionAppointementModel sessionAppointementModel;

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('d-M-yyyy').format(
      sessionAppointementModel.date,
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: s12, vertical: s8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(s8),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                padding: EdgeInsets.all(s5),
                width: 35,
                height: 35,
                child: Icon(
                  Icons.date_range_outlined,
                ),
              ),
              SizedBox(
                width: s8,
              ),
              Text(
                sessionAppointementModel.type,
                style: TextStyle(
                  color: getCurrentTheme()['NormalText'],
                  fontSize: s16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Text(
            date,
            style: TextStyle(
              color: getCurrentTheme()['NormalText'],
              fontSize: s16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
