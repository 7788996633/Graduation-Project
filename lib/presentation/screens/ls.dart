import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import 'issue_request/list_issue_requests_screen.dart';

class Ls extends StatelessWidget {
  const Ls({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => IssueRequestsBloc(),
                  child: const ListIssueRequestsScreen(),
                ),
              ),
            );
          },
          child: const Text(" issue requests"),
        ),
      ),
    );
  }
}
