import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(BottomNavVisible()) {
    on<ShowBottomNav>((event, emit) {
      if (state is! BottomNavVisible) {
        emit(BottomNavVisible());
      }
    });

    on<HideBottomNav>((event, emit) {
      if (state is! BottomNavHidden) {
        emit(BottomNavHidden());
      }
    });
  }
}
