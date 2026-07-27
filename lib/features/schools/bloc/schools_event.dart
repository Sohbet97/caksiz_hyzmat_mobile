part of 'schools_bloc.dart';

@immutable
sealed class SchoolsEvent extends Equatable {}

final class LoadSchools extends SchoolsEvent {
  final String? search;
  final int? cityId;
  final int limit;

  LoadSchools({this.search, this.cityId, this.limit = 20});

  @override
  List<Object?> get props => [search, cityId, limit];
}

final class LoadMoreSchools extends SchoolsEvent {
  @override
  List<Object?> get props => [];
}
