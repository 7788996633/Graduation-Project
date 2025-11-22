import 'package:meta/meta.dart';

@immutable
sealed class CompanyInfoEvent {}

class GetCompanyEvent extends CompanyInfoEvent {

  GetCompanyEvent();
}
class UpdateCompanyEvent extends CompanyInfoEvent {

  final String name;
  final String address;
  final String description;
  final String goals;
  final String vision;
  final DateTime foundationDate;

  UpdateCompanyEvent({

    required this.name,
    required this.address,
    required this.description,
    required this.goals,
    required this.vision,
    required this.foundationDate,
  });

}
