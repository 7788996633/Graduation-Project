import '../models/interview_model.dart';
import '../services/interview_services.dart';

class InterviewRepository {
  Future<List<InterviewModel>> getInterviews() async {
    var interviewList = await InterviewServices().getInterviews();
    return interviewList
        .map(
          (e) => InterviewModel.fromJson(e),
    )
        .toList();
  }
}
