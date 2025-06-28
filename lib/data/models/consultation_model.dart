class ConsultationModel {
  final int id;
  final String resault;
  final int lawyerId;
  final int consultationrRequestId;

  ConsultationModel(
      {required this.id,
      required this.resault,
      required this.lawyerId,
      required this.consultationrRequestId});

  factory ConsultationModel.fromJson(data) {
    return ConsultationModel(
      id: data['id'],
      resault: data['resault'],
      lawyerId: data['lawyerId'],
      consultationrRequestId: data['consultationrRequestId'],
    );
  }
}
