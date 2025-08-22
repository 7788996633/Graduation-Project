import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/categories/categories_bloc.dart';
import '../../blocs/categories/categories_event.dart';
import '../../data/models/categories_model.dart';

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

  // مسار التنقل (stack): كل مرة ندخل على أب نضيفه هون
  final List<CategoriesModel> _path = [];

  // قائمة المستوى الحالي المعروض
  List<CategoriesModel> _currentList = [];

  // الجذر (المستوى الأول)
  List<CategoriesModel> _root = [];

  @override
  void initState() {
    super.initState();
    selectedId = widget.initialId;
    // إذا لم يكن قد تم جلبها من الأب، نضمن الطلب هنا
    context.read<CategoriesBloc>().add(GetAllCategoriesEvent());
  }

  void _setRoot(List<CategoriesModel> root) {
    _root = root;
    _path.clear();
    _currentList = _root;
  }

  void _enter(CategoriesModel node) {
    if (node.children.isNotEmpty) {
      setState(() {
        _path.add(node);
        _currentList = node.children;
      });
    } else {
      // ورقة: اختيار نهائي
      setState(() {
        selectedId = node.id;
      });
      widget.onSelected(node.id, node.name);
      // إذا بدك تسكّر الـBottomSheet بعد الاختيار:
      // Navigator.of(context).pop();
    }
  }

  void _goBack() {
    setState(() {
      if (_path.isNotEmpty) {
        _path.removeLast();
        _currentList = _path.isEmpty ? _root : _path.last.children;
      }
    });
  }

  String get _title {
    if (_path.isEmpty) return 'Select Category';
    return _path.last.name;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const SizedBox(
              height: 260,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is CategoriesListLoaded) {
            // ضبط الجذر والمستوى الحالي أول مرة فقط
            if (_root.isEmpty) {
              _setRoot(state.list);
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              child: Column(
                children: [
                  // هيدر بسيط مع زر رجوع ومسار (breadcrumbs) اختياري
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                    child: Row(
                      children: [
                        if (_path.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: _goBack,
                            tooltip: 'رجوع',
                          ),
                        Expanded(
                          child: Text(
                            _title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // زر إغلاق اختياري
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                          tooltip: 'إغلاق',
                        ),
                      ],
                    ),
                  ),

                  // مسار بسيط (breadcrumbs) — اختياري
                  if (_path.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _path.clear();
                                  _currentList = _root;
                                });
                              },
                              child: Text('All',
                                  style: theme.textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                            ),
                            for (int i = 0; i < _path.length; i++) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Icon(Icons.chevron_right, size: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _path.removeRange(i + 1, _path.length);
                                    _currentList = _path.isEmpty
                                        ? _root
                                        : _path.last.children;
                                  });
                                },
                                child: Text(
                                  _path[i].name,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    fontWeight: i == _path.length - 1
                                        ? FontWeight.w700
                                        : FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                  const Divider(height: 1),

                  // القائمة المتغيرة حسب المستوى الحالي
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: _currentList.length,
                      itemBuilder: (context, index) {
                        final item = _currentList[index];
                        final hasChildren = item.children.isNotEmpty;
                        final isSelectedLeaf =
                            selectedId == item.id && !hasChildren;

                        return Card(
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            title: Text(
                              item.name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            onTap: () => _enter(item),
                            trailing: hasChildren
                                ? const Icon(Icons.chevron_right)
                                : (isSelectedLeaf
                                    ? const Icon(Icons.check_circle)
                                    : const Icon(Icons.radio_button_unchecked)),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CategoriesFail) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Error: ${state.errMsg}"),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
