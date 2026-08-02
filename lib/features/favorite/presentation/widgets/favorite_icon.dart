import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/favorite/bloc/favorite_bloc.dart';
import 'package:mobile/features/products/models/product_model.dart';

class FavoriteIconWidget extends StatelessWidget {
  const FavoriteIconWidget({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.select((FavoriteBloc bloc) {
      final state = bloc.state;
      return state is FavoriteLoaded && state.isFavorite(productModel.id);
    });

    return IconButton(
      onPressed: () => context.read<FavoriteBloc>().add(
        ToggleFavorite(productModel.id),
      ),
      visualDensity: VisualDensity.compact,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavorite),
          color: isFavorite ? Colors.red : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
