
import '../../models/lawyer_model.dart';
import '../filters_strategy.dart';

class SpecializationFilter implements FiltersStrategy<LawyerModel> {
  final String lawyerSpecialization;

  SpecializationFilter(this.lawyerSpecialization);

  @override
  bool apply(LawyerModel lawyer) {
    return lawyer.specialization == lawyerSpecialization;
  }
}
