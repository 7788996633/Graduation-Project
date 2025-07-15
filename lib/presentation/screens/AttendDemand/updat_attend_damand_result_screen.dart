import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../themes.dart';
import '../../../blocs/attend_Demand_bloc/attend_demand_bloc.dart';
import '../../../data/models/demand_model.dart';
import '../../widgets/custom_text_field.dart';

class UpdatAttendDamandResultScreen extends StatefulWidget {
  const UpdatAttendDamandResultScreen({super.key, required this.demandModel});
  final DemandModel demandModel;
  @override
  State<UpdatAttendDamandResultScreen> createState() =>
      _UpdatAttendDamandResultScreenState();
}

class _UpdatAttendDamandResultScreenState
    extends State<UpdatAttendDamandResultScreen> {
  TextEditingController resaultController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomTextFeild(
            text: "Enter The Resault",
            controller: resaultController,
            color: AppColors.darkBlue,
          ),
          BlocConsumer<AttendDemandBloc, AttendDemandState>(
            listener: (context, state) {
              if (state is DemandSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.successmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state is DemandFail) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.errmsg,
                      style: const TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              } else if (state is DemandLoading) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Loading ...",
                      style: TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Colors.grey,
                  ),
                );
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AttendDemandBloc>(context).add(
                    UpdateDemandResaultEvent(
                      idDemand: widget.demandModel.id,
                      resault: resaultController.text,
                    ),
                  );
                },
                child: Text(
                  "Save",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
