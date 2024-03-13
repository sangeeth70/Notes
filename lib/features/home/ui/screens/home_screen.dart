import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_by_sangeeth/data/cart_data.dart';
import 'package:notes_by_sangeeth/data/wishlist_data.dart';
import 'package:notes_by_sangeeth/features/home/bloc/home_bloc.dart';

import '../../../cart/ui/screens/cart_screen.dart';
import '../../../wishlist/ui/screens/wishlist_screen.dart';
import '../widgets/product_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = HomeBloc();
    homeBloc.add(HomeInitialEvent());
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous,current)=>current is HomeActionState,
      buildWhen:(previous,current)=>current is !HomeActionState,
    listener: (context, state) {
    if(state is CartNavigateState){
      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
    }
    if(state is WishlistNavigateState){
      Navigator.push(context, MaterialPageRoute(builder: (context) => WishlistScreen()));
    }
  },
      bloc: homeBloc,
  builder: (context, state) {
        switch(state.runtimeType){
          case HomeDataLoadedState:
            final successState = state as HomeDataLoadedState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Appbar", style: TextStyle(color: Colors.white)),
                backgroundColor: Theme.of(context).primaryColor,
                actions: [
                  IconButton(onPressed: (){
                    homeBloc.add(CartNavigateEvent());
                  }, icon: const Icon(Icons.shopping_cart)),
                  IconButton(onPressed: (){
                    print(successState.isWishlisted);
                    homeBloc.add(WishlistNavigateEvent());
                    successState.isWishlisted = false;
                    print(successState.isWishlisted);
                  }, icon: const Icon(Icons.favorite_border)),
                ],),
              body: ListView.builder(
                itemCount: successState.productData.length,
                itemBuilder: (context,index){
               return ProductTileWidget(homeBloc: homeBloc,onPressedCart: (){
                 cartItems.add(successState.productData[index]);
               },onPressedWishlist: (){
                final isAdd =  !wishlistItems.contains(successState.productData[index]);
                  if(isAdd){
                    wishlistItems.add(successState.productData[index]);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already added..")));
                  }

                 wishlistItems.forEach((e) {print(e.id);});
               },productDataModel: successState.productData[index],);
              }),
            );
          case HomeDataLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeDataErrorState:
            return const Scaffold(
              body: Center(
                child: Text("error"),
              ),
            );
          default:
           return const SizedBox();
        }
  },
);
  }
}
