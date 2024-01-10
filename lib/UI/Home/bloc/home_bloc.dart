import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/Model/Entity/Product.dart';
import 'package:nike/data/Model/Entity/banner.dart';
import 'package:nike/data/Repository/banner_repository.dart';
import 'package:nike/data/Repository/productrepository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BannerRepository bannerepository;
  final ProductRepository productRepository;
  HomeBloc({required this.bannerepository, required this.productRepository})
      : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted) {
        try {
          emit(HomeLoading());
          final banners = await bannerepository.getAll();
          final latestProducts = await productRepository.getAll(1);
          final popularProducts = await productRepository.getAll(2);
          emit(HomeSuccess(
              banners: banners,
              latestProduct: latestProducts,
              popularProduct: popularProducts));
        } catch (e) {
          emit(HomeError(messageErr: 'خطای نامشخص'));
        }
      }
    });
  }
}
