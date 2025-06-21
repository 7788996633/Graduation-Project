class LawyerModel {
  final int id;
  final String licenseNumber;
  final int experienceYears;
  final String certificate;
  final String specialization;
  final String name;
  final String email;
  final int age;
  final String address;
  final String phone;
  final String image;
  factory LawyerModel.fromJson(Map<String, dynamic> json) {
    return LawyerModel(
      id: json['id'],
      licenseNumber: json['license_number'],
      experienceYears: json['experience_years'],
      certificate: json['certificate'],
      specialization: json['specialization'],
      address: json['address'],
      name: json['name'],
      email: json['email'],
      age: json['age'],
      phone: json['phone'],
      image: json['image'],
    );
  }

  LawyerModel(
      {required this.id,
      required this.licenseNumber,
      required this.experienceYears,
      required this.certificate,
      required this.specialization,
      required this.name,
      required this.email,
      required this.age,
      required this.address,
      required this.phone,
      required this.image});
}
