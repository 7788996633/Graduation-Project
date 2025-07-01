import '../../models/lawyer_model.dart';
import '../filter_builder.dart';
import '../filters_strategy.dart';
import 'experience_years_filter.dart';
import 'specialization_filter.dart';

class LawyerFilterFactory {
  static FiltersStrategy<LawyerModel> build({
    String? specialization,
    int? minExperience,
  }) {
    final builder = FilterBuilder<LawyerModel>();

    if (specialization != null && specialization.isNotEmpty) {
      builder.add(
        SpecializationFilter(specialization),
      );
    }

    if (minExperience != null) {
      builder.add(
        ExperienceYearsFilter(minExperience),
      );
    }

    return builder.build();
  }
}
