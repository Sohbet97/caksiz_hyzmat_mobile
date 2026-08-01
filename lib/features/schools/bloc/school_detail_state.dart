part of 'school_detail_bloc.dart';

@immutable
sealed class SchoolDetailState extends Equatable {}

final class SchoolDetailInitial extends SchoolDetailState {
  @override
  List<Object?> get props => [];
}

final class GetSchoolDetailProgress extends SchoolDetailState {
  @override
  List<Object?> get props => [];
}

final class GetSchoolDetailSuccess extends SchoolDetailState {
  final SchoolDetailModel schoolDetailModel;

  GetSchoolDetailSuccess({required this.schoolDetailModel});

  @override
  List<Object?> get props => [schoolDetailModel];
}

final class GetSchoolDetailError extends SchoolDetailState {
  final String errorMessage;

  GetSchoolDetailError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
