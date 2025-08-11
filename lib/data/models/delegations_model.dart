
import 'lawyer_model.dart';
import 'session_model.dart';

class DelegationModel {
  final int id;
  final int sessionId;
  final int originalLawyerId;
  final int delegateLawyerId;
  final String status;
  final String adminNote;
  final String delegationFile;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LawyerModel originalLawyer;
  final LawyerModel delegateLawyer;
  final SessionModel session;

  DelegationModel({
    required this.id,
    required this.sessionId,
    required this.originalLawyerId,
    required this.delegateLawyerId,
    required this.status,
    required this.adminNote,
    required this.delegationFile,
    required this.createdAt,
    required this.updatedAt,
    required this.originalLawyer,
    required this.delegateLawyer,
    required this.session,
  });

  factory DelegationModel.fromJson(Map<String, dynamic> json) {
    return DelegationModel(
      id: json['id'],
      sessionId: json['session_id'],
      originalLawyerId: json['original_lawyer_id'],
      delegateLawyerId: json['delegate_lawyer_id'],
      status: json['status'] ?? '',
      adminNote: json['admin_note'] ?? '',
      delegationFile: json['delegation_file'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      originalLawyer: LawyerModel.fromJson(json['original_lawyer']),
      delegateLawyer: LawyerModel.fromJson(json['delegate_lawyer']),
      session: SessionModel.fromJson(json['session']),
    );
  }
}

