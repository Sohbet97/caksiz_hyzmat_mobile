import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:mobile/core/network/interceptors/interceptors.dart';
import 'package:mobile/core/storage/settings_storage.dart';
import 'package:mobile/features/favorite/bloc/favorite_bloc.dart';
import 'package:mobile/features/products/models/product_model.dart';

const _likeColor = Color(0xffEE4D2D);

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key, required this.productModel});
  final ProductModel productModel;

  Future<bool?> _onTap(BuildContext context, bool isLiked) async {
    final userId = await context.read<SettingsStorage>().readUserId();
    if (userId == null) {
      showGlobalMessage('Войдите в аккаунт, чтобы добавить в избранное');
      return isLiked;
    }
    if (!context.mounted) return isLiked;
    context.read<FavoriteBloc>().add(ToggleFavorite(productModel.id));
    return !isLiked;
  }

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select((FavoriteBloc bloc) {
      final state = bloc.state;
      return state is FavoriteLoaded && state.isFavorite(productModel.id);
    });

    return LikeButton(
      size: 22,
      isLiked: isFavorite,
      circleColor: const CircleColor(start: _likeColor, end: _likeColor),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: _likeColor,
        dotSecondaryColor: Color(0xffFFC107),
      ),
      likeBuilder: (isLiked) => Icon(
        isLiked ? Icons.favorite : Icons.favorite_border,
        size: 22,
        color: isLiked ? _likeColor : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onTap: (isLiked) => _onTap(context, isLiked),
    );
  }
}
