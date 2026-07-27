import 'package:flutter/material.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';

class SchoolListItem extends StatelessWidget {
  const SchoolListItem({super.key, required this.school, this.onTap});

  final SchoolModel school;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context);
    final thumbnailUrl = school.thumbnailMedia?.url;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: thumbnailUrl != null
                    ? Image.network(
                        thumbnailUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _Placeholder(theme: theme),
                      )
                    : _Placeholder(theme: theme),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      school.localizedName(locale),
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (school.city != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        school.city!.localizedName(locale),
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.chevron_right, color: theme.iconTheme.color),
            ],
          ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      color: theme.colorScheme.surface,
      child: Icon(Icons.school, color: theme.iconTheme.color),
    );
  }
}
