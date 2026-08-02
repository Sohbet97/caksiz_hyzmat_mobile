part of 'brand_bloc.dart';

sealed class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

final class LoadBrands extends BrandEvent {
  final BrandFilterModel filter;

  const LoadBrands(this.filter);

  @override
  List<Object> get props => [filter];
}

final class LoadMoreBrands extends BrandEvent {
  const LoadMoreBrands();
}

final class RefreshBrands extends BrandEvent {
  const RefreshBrands();
}
