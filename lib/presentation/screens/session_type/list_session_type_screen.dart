import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';

import '../../../themes.dart';
import '../../widgets/custom_appbar_add.dart';
import '../../widgets/session_type_item.dart';
import 'add_session_type.dart';

class ListSessionTypesScreen extends StatefulWidget {
  const ListSessionTypesScreen({super.key});

  @override
  State<ListSessionTypesScreen> createState() => _ListSessionTypesScreenState();
}

class _ListSessionTypesScreenState extends State<ListSessionTypesScreen> {
  late SessionTypeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SessionTypeBloc>(context);
    bloc.add(GetAllSessionTypesEvent());
  }

  Future<void> _onRefresh() async {
    bloc.add(GetAllSessionTypesEvent());
    await Future.delayed(const Duration(milliseconds: 400));
  }

  void _onSearch(String type) {
    if (type.trim().isNotEmpty) {
      bloc.add(SearchSessionTypesByTypeEvent(type: type));
    } else {
      bloc.add(GetAllSessionTypesEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: CustomActionAppBar(
        title: 'Session Types',
        actionIcon: Icons.add_circle_rounded,
        tooltip: 'Add New Session Type',
        onActionPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => SessionTypeBloc(),
                child: const AddSessionTypeScreen(),
              ),
            ),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // شريط البحث
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search by Type',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearch,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: BlocListener<SessionTypeBloc, SessionTypeState>(
                  listener: (context, state) {

                    if (state is UpdateSessionTypeEvent || state is AddSessionTypeEvent) {
                      bloc.add(GetAllSessionTypesEvent());
                    }
                  },
                  child: BlocBuilder<SessionTypeBloc, SessionTypeState>(
                    builder: (context, state) {
                      if (state is SessionTypeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SessionTypeFail) {
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
                      } else if (state is SessionTypeListLoaded) {
                        final sessionList = state.list;
                        if (sessionList.isEmpty) {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Text('No Session Types Available'),
                                ),
                              ),
                            ],
                          );
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.all(12),
                          itemCount: sessionList.length,
                          itemBuilder: (context, index) {
                            return SessionTypeItem(
                              sessionTypeModel: sessionList[index],
                            );
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
            ),
          ],
        ),
      ),
    );
  }
}
