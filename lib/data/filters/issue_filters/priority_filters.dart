
import '../../models/issues_model.dart';
import '../filters_strategy.dart';

class PriorityFilters implements FiltersStrategy<IssuesModel> {
  final String issuePriority;

  PriorityFilters(this.issuePriority);

  @override
  bool apply(IssuesModel issue) {
    return issue.priority == issuePriority;
  }
}
