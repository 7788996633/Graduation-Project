import 'and_filters.dart';
import 'filters_strategy.dart';

class FilterBuilder<T> {
  final List<FiltersStrategy<T>> _filters = [];

  FilterBuilder<T> add(FiltersStrategy<T> filter) {
    _filters.add(filter);
    return this;
  }

  FiltersStrategy<T> build() {
    if (_filters.isEmpty) {
      return _AllowAllFilter<T>();
    }
    if (_filters.length == 1) {
      return _filters.first;
    }
    return AndFilter(_filters);
  }
}

class _AllowAllFilter<T> implements FiltersStrategy<T> {
  @override
  bool apply(T item) => true;
}
