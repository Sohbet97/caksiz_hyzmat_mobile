part of 'category_bloc.dart';

@immutable
sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;
  final List<CategoryModel> treeList;

  const CategoryLoaded({required this.categories, required this.treeList});

  @override
  List<Object?> get props => [categories, treeList];
}

final class CategoryError extends CategoryState {
  final String message;

  const CategoryError({required this.message});

  @override
  List<Object?> get props => [message];
}
