import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mobile/features/schools/data/models/pagination.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';
import 'package:mobile/features/schools/data/repositories/schools_repository.dart';

part 'schools_event.dart';
part 'schools_state.dart';

class SchoolsBloc extends Bloc<SchoolsEvent, SchoolsState> {
  final SchoolsRepository schoolsRepository;

  SchoolsBloc({required this.schoolsRepository}) : super(SchoolsInitial()) {
    on<LoadSchools>(
      _onLoadSchools,
      transformer: (events, mapper) => events.distinct().asyncExpand(mapper),
    );
    on<LoadMoreSchools>(_onLoadMoreSchools);
  }

  Future<void> _onLoadSchools(
    LoadSchools event,
    Emitter<SchoolsState> emit,
  ) async {
    emit(SchoolsLoading());
    try {
      final response = await schoolsRepository.loadSchools(
        limit: event.limit,
        search: event.search,
        cityId: event.cityId,
      );
      emit(
        SchoolsLoaded(
          schools: response.data,
          meta: response.meta,
          search: event.search,
          cityId: event.cityId,
        ),
      );
    } catch (_) {
      emit(SchoolsError());
    }
  }

  Future<void> _onLoadMoreSchools(
    LoadMoreSchools event,
    Emitter<SchoolsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SchoolsLoaded ||
        currentState.isLoadingMore ||
        currentState.hasReachedMax) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));
    try {
      final response = await schoolsRepository.loadSchools(
        page: currentState.meta.page + 1,
        limit: currentState.meta.limit,
        search: currentState.search,
        cityId: currentState.cityId,
      );
      emit(
        currentState.copyWith(
          schools: [...currentState.schools, ...response.data],
          meta: response.meta,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      emit(currentState.copyWith(isLoadingMore: false));
    }
  }
}
