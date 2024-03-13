part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class WishlistNavigateEvent extends HomeEvent{}

class CartNavigateEvent extends HomeEvent{}

class AddToCartEvent extends HomeEvent{
  final ProductModel data;
  AddToCartEvent({required this.data});
}

class AddToWishlistEvent extends HomeEvent{
  final ProductModel data;
  AddToWishlistEvent({required this.data});
}




