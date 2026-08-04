import 'package:flutter/material.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../data/comment_repository.dart';
import '../../models/comment_model.dart';

class ProductDetailCommentsWidget extends StatefulWidget {
  const ProductDetailCommentsWidget({
    super.key,
    required this.productId,
    required this.rating,
    required this.reviewCount,
    required this.apiClient,
  });

  final int productId;
  final double rating;
  final int reviewCount;
  final ApiClient apiClient;

  @override
  State<ProductDetailCommentsWidget> createState() =>
      _ProductDetailCommentsWidgetState();
}

class _ProductDetailCommentsWidgetState
    extends State<ProductDetailCommentsWidget> {
  late final Future<List<CommentModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = CommentRepository(dio: widget.apiClient.dio)
        .getComments(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;
    final localization = S.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.productReviewsTitle,
            style: textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<CommentModel>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final comments = snapshot.data ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.rating.toStringAsFixed(1),
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: colors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Row(
                        children: List.generate(5, (i) {
                          final filled = i < widget.rating.round();
                          return Icon(
                            filled ? Icons.star_rounded : Icons.star_border_rounded,
                            size: 18,
                            color: colors.warning,
                          );
                        }),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '(${widget.reviewCount})',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: colors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 16,
                          color: colors.success,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          localization.productReviewsVerified,
                          style: textTheme.bodySmall?.copyWith(
                            color: colors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (comments.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        localization.productReviewsEmpty,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    )
                  else
                    ...comments.map(
                      (comment) => _CommentItem(comment: comment),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  const _CommentItem({required this.comment});

  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: colors.surfaceVariant,
                child: Icon(
                  Icons.person_outline,
                  size: 16,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                comment.userName,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(5, (i) {
              final filled = i < comment.rating.round();
              return Icon(
                filled ? Icons.star_rounded : Icons.star_border_rounded,
                size: 14,
                color: colors.warning,
              );
            }),
          ),
          const SizedBox(height: 6),
          Text(
            comment.text,
            style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}