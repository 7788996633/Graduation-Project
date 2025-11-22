import '../models/complaint_model.dart';
import '../services/complaint_services.dart';

class ComplaintRepository {
  Future<List<ComplaintModel>> getComplaints() async {
    var complaintsList = await ComplaintServices().getComplaints();
    return complaintsList
        .map((e) => ComplaintModel.fromJson(e))
        .toList();
  }

  Future<List<ComplaintModel>> getMyComplaints() async {
    var complaintsList = await ComplaintServices().getMyComplaints();
    return complaintsList
        .map((e) => ComplaintModel.fromJson(e))
        .toList();
  }
}
