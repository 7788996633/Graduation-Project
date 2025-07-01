part of 'lawyer_profiel_bloc.dart';

@immutable
sealed class LawyerProfileEvent {}

class CreateLawyerProfileEvent extends LawyerProfileEvent {
  final String licenseNumber;
  final String experienceYears;
  final String specialization;
  final String certificatePath;

  CreateLawyerProfileEvent(
      {required this.licenseNumber,
      required this.experienceYears,
      required this.specialization,
      required this.certificatePath});
}

class ShowLawyerProfileEvent extends LawyerProfileEvent {}

class ShowLawyerProfileByIdEvent extends LawyerProfileEvent {
  final int lawyerId;

  ShowLawyerProfileByIdEvent({required this.lawyerId});
}

class UpdateLawyerProfileEvent extends LawyerProfileEvent {
  final String licenseNumber;
  final String experienceYears;
  final String specialization;
  final String certificatePath;
  final String phone;
  final String imagePath;
  final String address;
  final String age;

  UpdateLawyerProfileEvent(
      {required this.licenseNumber,
      required this.experienceYears,
      required this.specialization,
      required this.certificatePath,
      required this.phone,
      required this.imagePath,
      required this.address,
      required this.age});
}

class DeleteLawyerProfileEvent extends LawyerProfileEvent {}
