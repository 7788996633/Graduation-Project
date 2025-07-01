
import 'filters_strategy.dart';

class AndFilter<T> implements FiltersStrategy<T> {
  final List<FiltersStrategy<T>> filters;

  AndFilter(this.filters);

  @override
  bool apply(T item) {
    return filters.every((filter) => filter.apply(item));
  }
}
