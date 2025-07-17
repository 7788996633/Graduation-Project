import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/models/categories_model.dart';
import '../../data/repositories/categories_repository.dart';
import 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesEvent>((event, emit) async {
      if (event is GetAllCategoriesEvent) {
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
