
import '../../models/issues_model.dart';
import '../filters_strategy.dart';

class StatusFilter implements FiltersStrategy<IssuesModel> {
  final String issueStatus;

  StatusFilter(this.issueStatus);

  @override
  bool apply(IssuesModel issue) {
    return issue.status == issueStatus;
  }
}
