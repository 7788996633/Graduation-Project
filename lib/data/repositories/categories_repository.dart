import '../models/categories_model.dart';
import '../services/categories_service.dart';

class CategoriesRepository {
  Future<List<CategoriesModel>> getCategories() async {
    var categoriesList = await CategoriesServices().getIssueCategories();
    return categoriesList
        .map(
          (e) => CategoriesModel.fromJson(e),
    )
        .toList();
  }
}
