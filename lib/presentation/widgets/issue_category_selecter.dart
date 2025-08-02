import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/categories/categories_event.dart';

class IssueCategorySelecter extends StatefulWidget {
  final Function(int id, String name) onSelected;
  final int? initialId;

  const IssueCategorySelecter({
    super.key,
    required this.onSelected,
    this.initialId,
  });

  @override
  State<IssueCategorySelecter> createState() => _IssueCategorySelecterState();
}

class _IssueCategorySelecterState extends State<IssueCategorySelecter> {
  int? selectedId;

  @override
  void initState() {
    super.initState();
    selectedId = widget.initialId;
    context.read<CategoriesBloc>().add(GetAllCategoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesListLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: state.list
                  .where(
                (element) => element.children.isEmpty,
              )
                  .map((sessionType) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 12.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: RadioListTile<int>(
                      contentPadding: const EdgeInsets.all(12),
                      title: Text(sessionType.name,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      value: sessionType.id,
                      groupValue: selectedId,
                      onChanged: (value) {
                        setState(() {
                          selectedId = value;
                        });
                        widget.onSelected(value!, sessionType.name);
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        } else if (state is CategoriesFail) {
          return Text("Error: ${state.errMsg}");
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
