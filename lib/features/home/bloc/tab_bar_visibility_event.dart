part of 'tab_bar_visibility_bloc.dart';

@immutable
sealed class TabBarVisibilityEvent {}

class ShowTabBar extends TabBarVisibilityEvent {}

class HideTabBar extends TabBarVisibilityEvent {}
