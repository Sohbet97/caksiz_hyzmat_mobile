part of 'bottom_navigation_bloc.dart';

@immutable
sealed class BottomNavigationState {}

final class BottomNavigationInitial extends BottomNavigationState {}

class BottomNavVisible extends BottomNavigationState {}

class BottomNavHidden extends BottomNavigationState {}
