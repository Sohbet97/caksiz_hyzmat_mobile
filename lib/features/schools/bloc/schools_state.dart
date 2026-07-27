part of 'schools_bloc.dart';

@immutable
sealed class SchoolsState extends Equatable {}

final class SchoolsInitial extends SchoolsState {
  @override
  List<Object?> get props => [];
}

final class SchoolsLoading extends SchoolsState {
  @override
  List<Object?> get props => [];
}

final class SchoolsLoaded extends SchoolsState {
  final List<SchoolModel> schools;
  final PaginationMeta meta;
  final String? search;
  final int? cityId;
  final bool isLoadingMore;

  SchoolsLoaded({
    required this.schools,
    required this.meta,
    this.search,
    this.cityId,
    this.isLoadingMore = false,
  });

  bool get hasReachedMax => !meta.hasNextPage;

  SchoolsLoaded copyWith({
    List<SchoolModel>? schools,
    PaginationMeta? meta,
    bool? isLoadingMore,
  }) {
    return SchoolsLoaded(
      schools: schools ?? this.schools,
      meta: meta ?? this.meta,
      search: search,
      cityId: cityId,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [schools, meta, search, cityId, isLoadingMore];
}

final class SchoolsError extends SchoolsState {
  @override
  List<Object?> get props => [];
}
