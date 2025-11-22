import 'package:meta/meta.dart';

@immutable
sealed class CategoriesEvent {}


class GetAllCategoriesEvent extends CategoriesEvent {}
