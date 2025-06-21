import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_bloc.dart';
import '../../../blocs/session_type_bloc/session_type_event.dart';

class SessionTypeSelector extends StatefulWidget {
  final Function(int id, String name) onSelected;
  final int? initialId;

  const SessionTypeSelector({
    super.key,
    required this.onSelected,
    this.initialId,
  });

  @override
  State<SessionTypeSelector> createState() => _SessionTypeSelectorState();
}

class _SessionTypeSelectorState extends State<SessionTypeSelector> {
  int? selectedId;

  @override
  void initState() {
    super.initState();
    selectedId = widget.initialId;
    context.read<SessionTypeBloc>().add(GetAllSessionTypesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionTypeBloc, SessionTypeState>(
      builder: (context, state) {
        if (state is SessionTypeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SessionTypeListLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.list.map((sessionType) {
              return RadioListTile<int>(
                title: Text(sessionType.type),
                subtitle: Text(sessionType.description),
                value: sessionType.id,
                groupValue: selectedId,
                onChanged: (value) {
                  setState(() {
                    selectedId = value;
                  });
                  widget.onSelected(value!, sessionType.type);
                },
              );
            }).toList(),
          );
        } else if (state is SessionTypeFail) {
          return Text("Error: ${state.errMsg}");
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
