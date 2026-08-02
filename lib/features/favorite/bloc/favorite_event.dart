part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

final class LoadFavorites extends FavoriteEvent {
  final FavoriteFilterModel filter;

  const LoadFavorites([this.filter = const FavoriteFilterModel()]);

  @override
  List<Object?> get props => [filter];
}

final class RefreshFavorites extends FavoriteEvent {
  const RefreshFavorites();
}

final class ToggleFavorite extends FavoriteEvent {
  final int productId;

  const ToggleFavorite(this.productId);

  @override
  List<Object?> get props => [productId];
}
