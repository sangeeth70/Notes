import 'package:flutter/material.dart';

import '../../bloc/home_bloc.dart';
import '../../models/product_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductModel productDataModel;
  final HomeBloc homeBloc;
  final void Function() onPressedWishlist;
  final void Function() onPressedCart;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.homeBloc, required this.onPressedWishlist, required this.onPressedCart});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(productDataModel.image))),
          ),
          const SizedBox(height: 20),
          Text(productDataModel.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$" + productDataModel.price.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: onPressedWishlist,
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: onPressedCart,
                      icon: Icon(Icons.shopping_bag_outlined)),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}