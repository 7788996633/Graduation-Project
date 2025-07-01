import 'package:graduation/data/models/lawyer_model.dart';

import '../filters_strategy.dart';

class ExperienceYearsFilter implements FiltersStrategy<LawyerModel> {
  final int minYears;

  ExperienceYearsFilter(this.minYears);

  @override
  bool apply(LawyerModel lawyer) {
    return lawyer.experienceYears >= minYears;
  }
}
