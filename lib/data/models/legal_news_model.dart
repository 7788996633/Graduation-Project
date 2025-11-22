class LegalNewsModel {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final String updatedAt;
  bool isSaved; // إضافة حالة الحفظ

  LegalNewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.isSaved = false, // القيمة الافتراضية غير محفوظ
  });

  factory LegalNewsModel.fromJson(Map<String, dynamic> json) {
    return LegalNewsModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      isSaved: json['is_saved'] ?? false, // قراءة حالة الحفظ من الـ JSON
    );
  }

  // لإرسال البيانات بعد تعديل isSaved إلى الـ API أو Bloc
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_saved': isSaved,
    };
  }
}
