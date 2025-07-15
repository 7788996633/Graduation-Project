import '../models/job_application_model.dart';
import '../services/job_application_service.dart';


class JobApplicationRepository {
  Future<List<JobApplicationModel>> getJobApplications() async {
    var jobApplicationList = await JobApplicationServices().getJobApplications();
    return jobApplicationList
        .map(
          (e) => JobApplicationModel.fromJson(e),
    )
        .toList();
  }

  Future<List<JobApplicationModel>> getMyJobApplications() async {
    var jobApplicationList = await JobApplicationServices().getJobApplications();
    return jobApplicationList
        .map(
          (e) => JobApplicationModel.fromJson(e),
    )
        .toList();
  }
}
