part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoading extends FavoriteState {}

final class FavoriteLoaded extends FavoriteState {
  final List<FavoriteModel> favorites;
  final FavoriteFilterModel filter;

  const FavoriteLoaded({required this.favorites, required this.filter});

  bool isFavorite(int productId) =>
      favorites.any((favorite) => favorite.productId == productId);

  FavoriteModel? favoriteFor(int productId) {
    for (final favorite in favorites) {
      if (favorite.productId == productId) return favorite;
    }
    return null;
  }

  FavoriteLoaded copyWith({
    List<FavoriteModel>? favorites,
    FavoriteFilterModel? filter,
  }) {
    return FavoriteLoaded(
      favorites: favorites ?? this.favorites,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [favorites, filter];
}

final class FavoriteError extends FavoriteState {
  final String message;
  final FavoriteFilterModel filter;

  const FavoriteError({required this.message, required this.filter});

  @override
  List<Object?> get props => [message];
}
