import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/complaints_bloc/complaint_bloc.dart';
import '../../../blocs/complaints_bloc/complaint_event.dart';
import '../../../blocs/complaints_bloc/complaint_state.dart';
import '../../../themes.dart';

import '../../widgets/custom_appbar_add.dart';
import '../../widgets/complaint_item.dart';
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
    await Future.delayed(const Duration(milliseconds: 400));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Complaints',
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
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: BlocBuilder<ComplaintBloc, ComplaintState>(
            builder: (context, state) {
              if (state is ComplaintLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ComplaintFail) {
                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(state.errMsg),
                      ),
                    ),
                  ],
                );
              } else if (state is ComplaintListLoaded) {
                final complaintsList = state.list;
                if (complaintsList.isEmpty) {
                  return ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: const [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('No Complaints Available'),
                        ),
                      ),
                    ],
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: complaintsList.length,
                  itemBuilder: (context, index) {
                    return ComplaintItem(complaintModel: complaintsList[index]);
                  },
                );
              }
              // الحالة المبدئية قابلة للسحب
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
              );
            },
          ),
        ),
      ),
    );
  }
}
