part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<ProductEntity> latestProduct;
  final List<ProductEntity> popularProduct;
  final List<BannerEntity> banners;

  HomeSuccess(
      {required this.latestProduct,
      required this.popularProduct,
      required this.banners});
}

final class HomeError extends HomeState {
  final String messageErr;

  HomeError({required this.messageErr});
}

final class HomeLoading extends HomeState {}
