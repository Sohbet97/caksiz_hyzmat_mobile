import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';
import '../models/person_model.dart';

class PersonDetailScreen extends StatelessWidget {
  const PersonDetailScreen({super.key, required this.person});

  final PersonModel person;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<AppColors>()!;
    final initial = person.fullName.trim().isNotEmpty
        ? person.fullName.trim()[0].toUpperCase()
        : '?';
    final avatarUrl = person.avatarExternalUrl;
    final memberSince = DateFormat('dd.MM.yyyy').format(person.createdAt);

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(title: const Text('Профиль')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Center(
              child: Container(
                width: 96,
                height: 96,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colors.primary, colors.secondary],
                  ),
                ),
                child: ClipOval(
                  child: avatarUrl != null
                      ? CachedNetworkImage(
                          imageUrl: avatarUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              _InitialAvatar(initial: initial, colors: colors),
                          errorWidget: (context, url, error) =>
                              _InitialAvatar(initial: initial, colors: colors),
                        )
                      : _InitialAvatar(initial: initial, colors: colors),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                person.fullName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            if (person.userType.isNotEmpty) ...[
              const SizedBox(height: 6),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    person.userType,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
            _InfoTile(
              icon: Icons.phone_outlined,
              label: 'Телефон',
              value: person.phoneNumber,
              verified: person.isPhoneVerified,
              colors: colors,
            ),
            _InfoTile(
              icon: Icons.email_outlined,
              label: 'Email',
              value: person.email,
              verified: person.isEmailVerified,
              colors: colors,
            ),
            _InfoTile(
              icon: Icons.calendar_today_outlined,
              label: 'На платформе с',
              value: memberSince,
              colors: colors,
            ),
          ],
        ),
      ),
    );
  }
}

class _InitialAvatar extends StatelessWidget {
  const _InitialAvatar({required this.initial, required this.colors});

  final String initial;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: colors.surface,
      child: Text(
        initial,
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: colors.primary,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    this.verified,
  });

  final IconData icon;
  final String label;
  final String? value;
  final bool? verified;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: colors.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          if (verified == true)
            Icon(Icons.verified_rounded, color: colors.success, size: 18),
        ],
      ),
    );
  }
}
