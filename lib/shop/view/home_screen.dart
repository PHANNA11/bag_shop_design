import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_bags/auth/view/login_screen.dart';
import 'package:shop_bags/shop/view/detail_product_screen.dart';
import 'package:badges/badges.dart' as badges;

import '../controller/product_cart_controller.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';
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
  CollectionReference dataRefProducts =
      FirebaseFirestore.instance.collection('Products');
  CollectionReference dataRefCategory =
      FirebaseFirestore.instance.collection('Categorys');
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
      child: GetBuilder<ProductCartController>(builder: (contexts) {
        return Scaffold(
          backgroundColor: Colors.white,
          drawer: Drawer(
            child: SafeArea(
              child: Column(
                children: [
                  ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().whenComplete(() {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                            (route) => false);
                      });
                    },
                    leading: const Icon(Icons.person),
                    title: const Text('Log Out'),
                    trailing: const Icon(Icons.logout),
                  )
                ],
              ),
            ),
          ),
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Women',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: StreamBuilder(
                    stream: dataRefCategory.orderBy("id").snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState ==
                              ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : snapshot.hasError
                              ? const Center(
                                  child: Text('Error data loading'),
                                )
                              : TabBar(
                                  onTap: (value) {
                                    // selected.value=value
                                    selected(value);

                                    if (value == 0) {
                                      setState(() {
                                        productsFilter = productList;
                                      });
                                    } else {
                                      setState(() {
                                        productsFilter = (productList
                                            .where((element) =>
                                                element.categoryId == value)
                                            .toList());
                                      });
                                    }
                                  },
                                  isScrollable: true,
                                  labelColor: Colors.black,
                                  dividerColor: Colors.white,
                                  indicatorColor: Colors.white,
                                  splashBorderRadius: BorderRadius.zero,
                                  overlayColor:
                                      const MaterialStatePropertyAll(
                                          Colors.white),
                                  tabs: List.generate(
                                    snapshot.data!.docs.length,
                                    (index) {
                                      final data = snapshot.data!.docs[index]
                                          .data() as Map<String, dynamic>;
                                      return Tab(
                                        child: DecoratedBox(
                                          decoration: BoxDecoration(
                                              color: selected.value == index
                                                  ? Colors.lightBlue
                                                  : const Color.fromARGB(
                                                      255, 205, 203, 203),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 8),
                                            child: Center(
                                              child: Text(
                                                data['name'].toString(),
                                                style: const TextStyle(
                                                    fontSize: 16),
                                                // overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                    },
                  )),

              // New code with FireBase
              Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                stream: dataRefProducts.snapshots(),
                builder: (context, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : snapshot.hasError
                          ? const Center(
                              child: Text('Error data loading'),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              //  physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                crossAxisCount: 2,
                                mainAxisExtent: 250,
                              ),
                              itemBuilder: (context, index) {
                                var data = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;

                                return Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          Get.to(() => DetailProductScreen(
                                                product: ProductModel(
                                                    code: data['code']
                                                        .toString(),
                                                    name: data['name']
                                                        .toString(),
                                                    categoryId: int.parse(
                                                        data['category_id']
                                                            .toString()),
                                                    backgroundColor:
                                                        data['background_color']
                                                            .toString(),
                                                    image: data['image']
                                                        .toString(),
                                                    qty: int.parse(data['qty']
                                                        .toString()),
                                                    size: double.parse(data['size']
                                                        .toString()),
                                                    description: data['description']
                                                        .toString(),
                                                    price: double.parse(
                                                        data['price'].toString()),
                                                    favorite: data['favorite'],
                                                    varriantColors: []),
                                              ));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Hero(
                                                tag:
                                                    '${data['name']}${data['code']}',
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: HexColor(data[
                                                              'background_color']
                                                          .toString()),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              data['image']
                                                                  .toString()))),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(data['name'].toString()),
                                                Text(data['code'].toString()),
                                              ],
                                            ),
                                            Text(
                                              '\$ ${data['price']}',
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            )
                                          ],
                                        )));
                              },
                            );
                },
              )),
              // Old Code
              // Expanded(
              //   child: GridView.builder(
              //     shrinkWrap: true,
              //     //  physics: NeverScrollableScrollPhysics(),
              //     itemCount: productsFilter.length,
              //     gridDelegate:
              //         const SliverGridDelegateWithFixedCrossAxisCount(
              //       mainAxisSpacing: 4,
              //       crossAxisSpacing: 4,
              //       crossAxisCount: 2,
              //       mainAxisExtent: 250,
              //     ),
              //     itemBuilder: (context, index) => Padding(
              //         padding: const EdgeInsets.all(4),
              //         child: GestureDetector(
              //             onTap: () {
              //               Get.to(() => DetailProductScreen(
              //                     product: productsFilter[index],
              //                   ));
              //             },
              //             child: Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Expanded(
              //                   child: Hero(
              //                     tag:
              //                         '${productsFilter[index].name}${productsFilter[index].code}',
              //                     child: Container(
              //                       decoration: BoxDecoration(
              //                           color: HexColor(productsFilter[index]
              //                               .backgroundColor!
              //                               .toString()),
              //                           borderRadius:
              //                               BorderRadius.circular(10),
              //                           image: DecorationImage(
              //                               image: AssetImage(
              //                                   productsFilter[index]
              //                                       .image
              //                                       .toString()))),
              //                     ),
              //                   ),
              //                 ),
              //                 Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Text(productsFilter[index].name.toString()),
              //                     Text(productsFilter[index].code.toString()),
              //                   ],
              //                 ),
              //                 Text(
              //                   '\$ ${productsFilter[index].price}',
              //                   style: const TextStyle(
              //                       color: Colors.red,
              //                       fontWeight: FontWeight.bold),
              //                 )
              //               ],
              //             ))),
              //   ),
              // ),
            ],
          ),
        );
      }),
    );
  }
}
