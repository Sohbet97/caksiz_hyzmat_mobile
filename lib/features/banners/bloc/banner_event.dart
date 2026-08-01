part of 'banner_bloc.dart';

sealed class BannerEvent extends Equatable {
  const BannerEvent();

  @override
  List<Object?> get props => [];
}

final class LoadBanners extends BannerEvent {
  final BannerFilterModel filter;

  const LoadBanners(this.filter);

  @override
  List<Object?> get props => [filter];
}

final class RefreshBanners extends BannerEvent {
  const RefreshBanners();
}
