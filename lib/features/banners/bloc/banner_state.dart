part of 'banner_bloc.dart';

sealed class BannerState extends Equatable {
  const BannerState();

  @override
  List<Object?> get props => [];
}

final class BannerInitial extends BannerState {}

final class BannerLoading extends BannerState {}

final class BannerLoaded extends BannerState {
  final List<BannerModel> banners;
  final BannerFilterModel filter;

  const BannerLoaded({required this.banners, required this.filter});

  @override
  List<Object?> get props => [banners, filter];
}

final class BannerError extends BannerState {
  final String message;
  final BannerFilterModel? filter;

  const BannerError({required this.message, this.filter});

  @override
  List<Object?> get props => [message];
}
