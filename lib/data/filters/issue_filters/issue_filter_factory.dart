import 'package:graduation/data/filters/issue_filters/status_filter.dart';
import 'package:graduation/data/models/issues_model.dart';

import '../filter_builder.dart';
import '../filters_strategy.dart';
import 'priority_filters.dart';

class IssueFilterFactory {
  static FiltersStrategy<IssuesModel> build({
    String? status,
    String? priority,
  }) {
    final builder = FilterBuilder<IssuesModel>();

    if (status != null && status.isNotEmpty) {
      builder.add(
        StatusFilter(status),
      );
    }

    if (priority != null && priority.isNotEmpty) {
      builder.add(
        PriorityFilters(priority),
      );
    }

    return builder.build();
  }
}
