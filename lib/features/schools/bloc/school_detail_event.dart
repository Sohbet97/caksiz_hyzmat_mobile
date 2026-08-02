part of 'school_detail_bloc.dart';

@immutable
sealed class SchoolDetailEvent extends Equatable {}

final class GetSchoolDetailEvent extends SchoolDetailEvent {
  final int schoolId;

  GetSchoolDetailEvent({required this.schoolId});

  @override
  List<Object?> get props => [schoolId];
}
