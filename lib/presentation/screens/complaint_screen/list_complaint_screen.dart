import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_event.dart';
import '../../../themes.dart';

import '../../widgets/complaint_list.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/custom_search_bar.dart';
import 'add_complaint_screen.dart';

class ListComplaintsScreen extends StatefulWidget {
  const ListComplaintsScreen({super.key});

  @override
  State<ListComplaintsScreen> createState() => _ListComplaintsScreenState();
}

class _ListComplaintsScreenState extends State<ListComplaintsScreen> {
  late ComplaintBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ComplaintBloc>(context);
    bloc.add(GetAllComplaintsEvent());
  }



  Future<void> _onRefresh() async {
    bloc.add(GetAllComplaintsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'List Complaints',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Complaint',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => ComplaintBloc(),
                child: const AddComplaintScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
       child:
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: AppColors.darkBlue,
                child: ComplaintList(bloc: bloc),
              ),
            ),

      ),
    );
  }
}
