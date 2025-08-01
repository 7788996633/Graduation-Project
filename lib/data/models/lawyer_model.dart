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

  LawyerModel({
    required this.id,
    required this.licenseNumber,
    required this.experienceYears,
    required this.certificate,
    required this.specialization,
    required this.name,
    required this.email,
    required this.age,
    required this.address,
    required this.phone,
    required this.image,
  });

  factory LawyerModel.fromJson(Map<String, dynamic> json) {
    return LawyerModel(
      id: json['id'] ?? 0,
      licenseNumber: json['license_number']?.toString() ?? '',
      experienceYears: json['experience_years'] ?? 0,
      certificate: json['certificate']?.toString() ?? '',
      specialization: json['specialization']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      age: json['age'] ?? 0,
      address: json['address']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'license_number': licenseNumber,
      'experience_years': experienceYears,
      'certificate': certificate,
      'specialization': specialization,
      'name': name,
      'email': email,
      'age': age,
      'address': address,
      'phone': phone,
      'image': image,
    };
  }
}
