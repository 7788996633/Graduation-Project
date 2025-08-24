class LegalBookModel {
  final int id;
  final String bookTitle;

  final String book;
  final String createdAt;
  final String updatedAt;

  LegalBookModel({
    required this.id,
    required this.bookTitle,

    required this.book,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LegalBookModel.fromJson(Map<String, dynamic> json) {
    return LegalBookModel(
      id: json['id'],
      bookTitle: json['bookTitle'],

      book: json['book'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookTitle': bookTitle,
      'book': book,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
