import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tab_bar_visibility_event.dart';
part 'tab_bar_visibility_state.dart';

class TabBarVisibilityBloc
    extends Bloc<TabBarVisibilityEvent, TabBarVisibilityState> {
  TabBarVisibilityBloc() : super(TabBarVisible()) {
    on<ShowTabBar>((event, emit) {
      if (state is! TabBarVisible) {
        emit(TabBarVisible());
      }
    });

    on<HideTabBar>((event, emit) {
      if (state is! TabBarHidden) {
        emit(TabBarHidden());
      }
    });
  }
}
