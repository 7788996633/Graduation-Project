class UserProfileModel {
  final String name;
  final String email;
  final String address;
  final String phone;
  final String scientificLevel;
  final int age;
  final int userId;
  final String image;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone: json['phone'],
      scientificLevel: json['scientificLevel'],
      age: json['age'],
      userId: json['user_id'],
      image: json['image'] ??
          'https://www.bing.com/images/search?view=detailV2&ccid=NNhwFpPt&id=68441E04E20B0E1327B7D3995F865058E6A2C60B&thid=OIP.NNhwFpPthZ37t_dE9Bx8yQHaHV&mediaurl=https%3a%2f%2fwww.pngitem.com%2fpimgs%2fm%2f22-224249_blank-person-hd-png-download.png&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.34d8701693ed859dfbb7f744f41c7cc9%3frik%3dC8ai5lhQhl%252bZ0w%26pid%3dImgRaw%26r%3d0&exph=852&expw=860&q=empty+person&simid=607996623880089502&FORM=IRPRST&ck=5A9BE0E3652EFE0D7A9101CE471F7D91&selectedIndex=0&itb=0',
    );
  }

  UserProfileModel({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.scientificLevel,
    required this.age,
    required this.userId,
    required this.image,
  });
}
