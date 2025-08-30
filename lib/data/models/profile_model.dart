import '../../constant.dart';

class ProfileModel {
  final int id;
  final String address;
  final String phone;
  final String scientificLevel;
  final int age;
  final String image;

  ProfileModel(
      {required this.id,
      required this.address,
      required this.phone,
      required this.scientificLevel,
      required this.age,
      required this.image});

  factory ProfileModel.fromjson(data) {
    return ProfileModel(
      id: data['id'],
      address: data['address'],
      age: data['age'],
      image: 'https://azhri.net/${data['image']}',
      phone: data['phone'],
      scientificLevel: data['scientificLevel'],
    );
  }
}
