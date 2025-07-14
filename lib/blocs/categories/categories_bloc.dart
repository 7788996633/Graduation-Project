import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/categories_model.dart';
import '../../data/models/issues_model.dart';
import '../../data/repositories/categories_repository.dart';
import '../../data/services/categories_service.dart';
import 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) async {
      if (event is GetCategoriesByIdEvent) {
        emit(CategoriesLoading());
        try {
          final category = await CategoriesServices()
              .getIssuesByCategory(event.categoryId);
          emit(CategoriesLoaded(category: category));
        } catch (e) {
          emit(CategoriesFail(errMsg: e.toString()));
        }
      } else if (event is GetAllCategoriesEvent) {
        emit(CategoriesLoading());
        try {
          final data = await CategoriesRepository().getCategories();
          emit(CategoriesListLoaded(list: data));
        } catch (e) {
          emit(CategoriesFail(errMsg: e.toString()));
        }
      }
    });
  }
}
