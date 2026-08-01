part of 'brand_bloc.dart';

sealed class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

final class BrandInitial extends BrandState {}

final class BrandLoading extends BrandState {}

final class BrandLoaded extends BrandState {
  final List<BrandModel> brands;
  final bool hasMore;
  final bool isLoadingMore;
  final BrandFilterModel filter;

  const BrandLoaded({
    required this.brands,
    required this.hasMore,
    required this.filter,
    this.isLoadingMore = false,
  });

  BrandLoaded copyWith({
    List<BrandModel>? brands,
    bool? hasMore,
    bool? isLoadingMore,
    BrandFilterModel? filter,
  }) {
    return BrandLoaded(
      brands: brands ?? this.brands,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [brands, hasMore, isLoadingMore, filter];
}

final class BrandError extends BrandState {
  final String message;
  final BrandFilterModel? filter;

  const BrandError({required this.message, required this.filter});

  @override
  List<Object> get props => [message];
}
