import '../models/interview_model.dart';
import '../services/interview_services.dart';

class InterviewRepository {
  final InterviewServices _interviewServices = InterviewServices();

  Future<List<InterviewModel>> getInterviews(int jobAppId) async {
    var interviewList = await _interviewServices.getInterviews(jobAppId);
    return interviewList
        .map((e) => InterviewModel.fromJson(e))
        .toList();
  }
}