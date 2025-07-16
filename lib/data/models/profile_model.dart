
import '../../constant.dart';

class ProfileModel {
  final int id;
  final String address;
  final String phone;
  final String scientificLevel;
  final int age;
  final String image;

  ProfileModel({required this.id,
    required this.address,
    required this.phone,
    required this.scientificLevel,
    required this.age,
    required this.image});

  factory ProfileModel.fromjson(data) {
    return ProfileModel(
      id: data['id'] ?? 0,
      address: data['address'] ?? 'غير معروف',
      age: data['age'] ?? 0,
      phone: data['phone'] ?? 'لا يوجد',
      scientificLevel: data['scientificLevel'] ?? 'غير محدد',
      image: data['image'] != null
          ? 'http://$ip:8000/${data['image']}'
          : 'https://example.com/default-image.png',
    );
  }
}
