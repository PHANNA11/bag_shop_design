import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controller/product_cart_controller.dart';

class CartListScreen extends StatelessWidget {
  CartListScreen({super.key});
  final productCartController = Get.put(ProductCartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Cart'),
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: productCartController.cartList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    const BoxShadow(spreadRadius: 0.2, color: Colors.grey)
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                height: 100,
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor(productCartController
                                .cartList[index].backgroundColor
                                .toString()),
                            image: DecorationImage(
                                image: AssetImage(productCartController
                                    .cartList[index].image
                                    .toString()))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            productCartController.cartList[index].name
                                .toString(),
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '\$ ${productCartController.cartList[index].price}',
                                style: const TextStyle(
                                    fontSize: 15, color: Colors.red),
                              ),
                              Text(
                                ' x ${productCartController.cartList[index].qty}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () async {
                          productCartController.removeItemFromCart(
                              pro: productCartController.cartList[index]);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
