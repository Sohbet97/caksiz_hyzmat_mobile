import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/schools/data/models/school_detail_model.dart';
import 'package:mobile/features/schools/data/repositories/schools_repository.dart';

part 'school_detail_event.dart';
part 'school_detail_state.dart';

class SchoolDetailBloc extends Bloc<SchoolDetailEvent, SchoolDetailState> {
  final SchoolsRepository schoolsRepository;

  SchoolDetailBloc({required this.schoolsRepository})
    : super(SchoolDetailInitial()) {
    on<GetSchoolDetailEvent>(_onLoadSchoolDetail);
  }

  Future<void> _onLoadSchoolDetail(
    GetSchoolDetailEvent event,
    Emitter<SchoolDetailState> emit,
  ) async {
    try {
      emit(GetSchoolDetailProgress());
      final result = await schoolsRepository.loadSchoolDetail(event.schoolId);
      emit(GetSchoolDetailSuccess(schoolDetailModel: result));
    } catch (e) {
      emit(GetSchoolDetailError(errorMessage: e.toString()));
    }
  }
}
