import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/lawyer_bloc/lawyer_bloc.dart';
import '../../../blocs/lawyer_bloc/lawyer_event.dart';
import '../../data/filters/filters_strategy.dart';
import '../../data/models/lawyer_model.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/all_lawyers_list.dart';
import '../widgets/lawyer_filter_bottom_sheet.dart';
import '../widgets/refresh_button.dart';

class AllLawyersScreen extends StatefulWidget {
  const AllLawyersScreen({super.key});

  @override
  State<AllLawyersScreen> createState() => _AllLawyersScreenState();
}

class _AllLawyersScreenState extends State<AllLawyersScreen> {
  late LawyerBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LawyerBloc>(context);
    bloc.add(
      GetAllLawyersEvent(),
    );
  }

  void _onSearch(String lawyerName) {
    if (lawyerName.trim().isNotEmpty) {
      bloc.add(
        SearchLawyersByNameEvent(
          name: lawyerName,
        ),
      );
    } else {
      bloc.add(
        GetAllLawyersEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F6),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            onPressed: () async {
              final filter =
                  await showModalBottomSheet<FiltersStrategy<LawyerModel>>(
                context: context,
                builder: (_) => const LawyerFilterBottomSheet(),
              );
              if (filter != null) {
                bloc.add(FilterLawyers(filter));
              }
            },
          ),
        ],
        title: const Text(
          'Lawyers Directory',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 8,
        backgroundColor: const Color(0XFF472A0C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(
              hint: 'Search by Lawyer Name',
              onSearch: _onSearch,
            ),
            const SizedBox(height: 20),
            AllLawyersList(
              bloc: bloc,
            ),
          ],
        ),
      ),
      floatingActionButton: RefreshButton(
        onPressed: () {
          bloc.add(
            GetAllLawyersEvent(),
          );
        },
      ),
    );
  }
}
