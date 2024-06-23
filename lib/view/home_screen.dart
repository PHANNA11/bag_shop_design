import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_bags/controller/product_cart_controller.dart';
import 'package:shop_bags/model/category_model.dart';
import 'package:shop_bags/model/product_model.dart';
import 'package:shop_bags/view/detail_product_screen.dart';
import 'package:badges/badges.dart' as badges;

import 'cart_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProductModel> productsFilter = [];
  final productCartController = Get.put(ProductCartController());
  RxInt selected = 0.obs;
  @override
  void initState() {
    // TODO: implement initState
    selected = 0.obs;
    productsFilter = productList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoryList.length,
      child: GetBuilder<ProductCartController>(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          drawer: const Drawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                  )),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => CartListScreen());
                  },
                  child: badges.Badge(
                    showBadge:
                        productCartController.cartList.isEmpty ? false : true,
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    badgeContent:
                        Text(productCartController.cartList.length.toString()),
                    child: const Icon(
                      Icons.shopping_cart,
                      size: 25,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Women',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TabBar(
                      onTap: (value) {
                        // selected.value=value
                        selected(value);
                        log('SelectId:$value');

                        if (value == 0) {
                          setState(() {
                            productsFilter = productList;
                          });
                        } else {
                          setState(() {
                            productsFilter = (productList
                                .where((element) => element.categoryId == value)
                                .toList());
                          });
                        }

                        log(productsFilter.toList().toString());
                      },
                      isScrollable: true,
                      labelColor: Colors.black,
                      dividerColor: Colors.white,
                      indicatorColor: Colors.white,
                      splashBorderRadius: BorderRadius.zero,
                      overlayColor:
                          const MaterialStatePropertyAll(Colors.white),
                      tabs: List.generate(
                        categoryList.length,
                        (index) => Tab(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: selected.value == index
                                    ? Colors.lightBlue
                                    : const Color.fromARGB(255, 205, 203, 203),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Text(
                                  categoryList[index].name.toString(),
                                  style: const TextStyle(fontSize: 16),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    //  physics: NeverScrollableScrollPhysics(),
                    itemCount: productsFilter.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      crossAxisCount: 2,
                      mainAxisExtent: 250,
                    ),
                    itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(4),
                        child: GestureDetector(
                            onTap: () {
                              Get.to(() => DetailProductScreen(
                                    product: productsFilter[index],
                                  ));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Hero(
                                    tag:
                                        '${productsFilter[index].name}${productsFilter[index].code}',
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: HexColor(productsFilter[index]
                                              .backgroundColor!
                                              .toString()),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  productsFilter[index]
                                                      .image
                                                      .toString()))),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(productsFilter[index].name.toString()),
                                    Text(productsFilter[index].code.toString()),
                                  ],
                                ),
                                Text(
                                  '\$ ${productsFilter[index].price}',
                                  style: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
