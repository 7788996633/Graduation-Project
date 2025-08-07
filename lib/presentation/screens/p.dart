import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/issue_requests_bloc/issue_requests_bloc.dart';
import 'issue_request/add_issue_request.dart';

class P extends StatelessWidget {
  const P({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => IssueRequestsBloc(), // بدون أي أحداث هنا
                    child: const AddIssueRequestScreen(),
                  ),
                ));
          },
          child: const Text("add issue request "),
        ),
      ),
    );
  }
}
