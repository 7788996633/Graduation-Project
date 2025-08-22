part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}

final class CategoriesLoading extends CategoriesState {}

final class CategoriesSuccess extends CategoriesState {
  final String successMsg;

  CategoriesSuccess({required this.successMsg});
}

final class CategoriesLoaded extends CategoriesState {
  final CategoriesModel category;


  CategoriesLoaded({
    required this.category,

  });
}

final class CategoriesListLoaded extends CategoriesState {
  final List<CategoriesModel> list;

  CategoriesListLoaded({required this.list});
}

final class CategoriesFail extends CategoriesState {
  final String errMsg;

  CategoriesFail({required this.errMsg});
}
