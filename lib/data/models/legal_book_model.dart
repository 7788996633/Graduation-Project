class LegalBookModel {
  final int id;
  final String bookTitle;
  final String book;
  final String createdAt;
  final String updatedAt;
  bool isSaved; // تم الإضافة هنا

  LegalBookModel({
    required this.id,
    required this.bookTitle,
    required this.book,
    required this.createdAt,
    required this.updatedAt,
    this.isSaved = false, // القيمة الافتراضية false
  });

  factory LegalBookModel.fromJson(Map<String, dynamic> json) {
    return LegalBookModel(
      id: json['id'],
      bookTitle: json['bookTitle'],
      book: json['book'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isSaved: json['is_saved'] ?? false, // إذا لم يكن موجودًا، نعتبره false
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookTitle': bookTitle,
      'book': book,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_saved': isSaved, // إضافة الحقل هنا
    };
  }
}
