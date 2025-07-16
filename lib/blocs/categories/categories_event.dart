import 'package:meta/meta.dart';

@immutable
sealed class CategoriesEvent {}

class GetCategoriesByIdEvent extends CategoriesEvent {
  final int categoryId;
  GetCategoriesByIdEvent({required this.categoryId});
}

class GetAllCategoriesEvent extends CategoriesEvent {}
