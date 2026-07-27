import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/schools/data/repositories/schools_repository.dart';

part 'schools_event.dart';
part 'schools_state.dart';

class SchoolsBloc extends Bloc<SchoolsEvent, SchoolsState> {
  final SchoolsRepository schoolsRepository;
  SchoolsBloc({required this.schoolsRepository}) : super(SchoolsInitial()) {
    on<SchoolsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
