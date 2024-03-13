part of 'home_bloc.dart';

@immutable

abstract class HomeState {}

abstract class HomeActionState extends HomeState{}

class HomeInitialState extends HomeState {}

class HomeDataLoadingState extends HomeState {}

class HomeDataLoadedState extends HomeState {
  final List<ProductModel> productData;
  late final bool isWishlisted;
  HomeDataLoadedState({required this.productData,this.isWishlisted = false});
}

class HomeDataErrorState extends HomeState {}

class WishlistNavigateState extends HomeActionState{}

class CartNavigateState extends HomeActionState{}
