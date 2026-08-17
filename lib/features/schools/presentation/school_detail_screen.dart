import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/features/schools/bloc/school_detail_bloc.dart';
import 'package:mobile/features/schools/data/models/school_model.dart';
import 'package:mobile/features/schools/presentation/widgets/school_error_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../generated/l10n.dart';
import '../data/models/school_detail_model.dart';
import 'widgets/school_detail_faculties_widget.dart';
import 'widgets/school_detail_gallery_widget.dart';
import 'widgets/school_detail_info_widget.dart';
import 'widgets/school_detail_stats_widget.dart';

class SchoolDetailScreen extends StatelessWidget {
  const SchoolDetailScreen({super.key, required this.schoolModel});
  final SchoolModel schoolModel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: BlocBuilder<SchoolDetailBloc, SchoolDetailState>(
        builder: (context, state) {
          if (state is GetSchoolDetailProgress ||
              state is SchoolDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetSchoolDetailError) {
            return SchoolErrorWidget(
              errorText: state.errorMessage,
              onTap: () {
                context.read<SchoolDetailBloc>().add(
                  GetSchoolDetailEvent(schoolId: schoolModel.id),
                );
              },
              title: S.of(context).schoolsLoadError,
            );
          }

          if (state is GetSchoolDetailSuccess) {
            return _SchoolDetailBody(detail: state.schoolDetailModel);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _SchoolDetailBody extends StatefulWidget {
  const _SchoolDetailBody({required this.detail});

  final SchoolDetailModel detail;

  @override
  State<_SchoolDetailBody> createState() => _SchoolDetailBodyState();
}

class _SchoolDetailBodyState extends State<_SchoolDetailBody> {
  bool _descriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    final detail = widget.detail;
    final colors = Theme.of(context).extension<AppColors>()!;
    final locale = Localizations.localeOf(context);
    final localization = S.of(context);
    final name = detail.localizedName(locale);
    final description = detail.localizedDescription(locale);
    final media = buildSchoolMediaList(detail);

    const logoSize = 84.0;
    const overlap = logoSize / 2;
    const galleryHeight = 240.0;
    const containerTranslate = 16.0;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SchoolDetailGalleryWidget(
                      media: media,
                      onSharePressed: () {
                        SharePlus.instance.share(
                          ShareParams(text: name),
                        );
                      },
                      onFavoritePressed: () {
                        // TODO: halanlaryma goş
                      },
                    ),
                    Transform.translate(
                      offset: const Offset(0, -containerTranslate),
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: overlap - 40),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: logoSize + 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        fontFamily: 'serif',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17,
                                        color: colors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Icon(
                                    Icons.verified,
                                    color: colors.warning,
                                    size: 17,
                                  ),
                                ],
                              ),
                            ),
                            if (detail.city != null) ...[
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 15,
                                    color: colors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    detail.city!.localizedName(locale),
                                    style: TextStyle(
                                      color: colors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            if (description != null &&
                                description.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text(
                                description,
                                maxLines: _descriptionExpanded ? null : 3,
                                overflow: _descriptionExpanded
                                    ? TextOverflow.visible
                                    : TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: colors.textPrimary,
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              GestureDetector(
                                onTap: () => setState(
                                  () => _descriptionExpanded =
                                      !_descriptionExpanded,
                                ),
                                child: Text(
                                  _descriptionExpanded
                                      ? localization.schoolDetailReadLess
                                      : localization.schoolDetailReadMore,
                                  style: TextStyle(
                                    color: colors.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            SchoolDetailStatsWidget(detail: detail),
                            SchoolDetailFacultiesWidget(
                              kafedralar: detail.kafedralar,
                            ),
                            SchoolDetailInfoWidget(detail: detail),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 16,
                  top: galleryHeight - containerTranslate - overlap + 16,
                  child: Container(
                    width: logoSize,
                    height: logoSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF3E2115),
                      border: Border.all(color: colors.background, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: colors.shadow,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: detail.thumbnailMedia?.fullUrl.isNotEmpty == true
                        ? Image.network(
                            detail.thumbnailMedia!.fullUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                _LogoPlaceholder(name: name, colors: colors),
                          )
                        : _LogoPlaceholder(name: name, colors: colors),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: colors.background,
            boxShadow: [
              BoxShadow(
                color: colors.shadow,
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.bookmark_border, size: 18),
                      label: Text(localization.schoolDetailSave),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.primary,
                        side: BorderSide(color: colors.primary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline, size: 18),
                      label: Text(localization.schoolDetailAskQuestion),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _LogoPlaceholder extends StatelessWidget {
  const _LogoPlaceholder({required this.name, required this.colors});

  final String name;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_balance, color: colors.warning, size: 22),
          const SizedBox(height: 3),
          Text(
            name.toUpperCase(),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colors.warning,
              fontSize: 6.5,
              fontWeight: FontWeight.w700,
              height: 1.1,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}