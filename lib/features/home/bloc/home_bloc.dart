import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/product_data.dart';
import '../models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super( HomeInitialState()) {

    on<HomeInitialEvent>(homeInitialEvent);

    on<WishlistNavigateEvent>(wishlistNavigateEvent);

    on<CartNavigateEvent>(cartNavigateEvent);

    on<AddToCartEvent>(addToCartEvent);

    on<AddToWishlistEvent>(addToWishlistEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit)async {
    try{
      emit(HomeDataLoadingState());
      // await Future.delayed(const Duration(seconds: 1));
      emit(HomeDataLoadedState(productData: Products.products.map((e) => ProductModel(id: e['id'], name: e['product_name'], image: e['image_url'],price: e['price'])).toList()));
    }catch(err){
      emit(HomeDataErrorState());
    }
  }

  FutureOr<void> wishlistNavigateEvent(WishlistNavigateEvent event, Emitter<HomeState> emit) {
    print("wishlist screen navigate");
    emit(WishlistNavigateState());
  }

  FutureOr<void> cartNavigateEvent(CartNavigateEvent event, Emitter<HomeState> emit) {
    print("cart screen navigate");
    emit(CartNavigateState());
  }

  FutureOr<void> addToCartEvent(AddToCartEvent event, Emitter<HomeState> emit) {
    print("add to cart");
  }

  FutureOr<void> addToWishlistEvent(AddToWishlistEvent event, Emitter<HomeState> emit) {
    print("add to wishlist");
  }
}
