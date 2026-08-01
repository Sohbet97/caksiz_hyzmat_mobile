part of 'tab_bar_visibility_bloc.dart';

@immutable
sealed class TabBarVisibilityState {}

final class TabBarVisibilityInitial extends TabBarVisibilityState {}

class TabBarVisible extends TabBarVisibilityState {}

class TabBarHidden extends TabBarVisibilityState {}
