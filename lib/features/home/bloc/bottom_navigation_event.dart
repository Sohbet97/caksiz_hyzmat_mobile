part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationEvent {}

class ShowBottomNav extends BottomNavigationEvent {}

class HideBottomNav extends BottomNavigationEvent {}
