import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_bags/shop/view/account/add_edit_product.dart';

import '../../model/product_model.dart';
import '../shop/detail_product_screen.dart';

class ViewProductList extends StatefulWidget {
  const ViewProductList({super.key});

  @override
  State<ViewProductList> createState() => _ViewProductListState();
}

class _ViewProductListState extends State<ViewProductList> {
  CollectionReference dataRefProducts =
      FirebaseFirestore.instance.collection('Products');
  CollectionReference dataRefCategory =
      FirebaseFirestore.instance.collection('Categorys');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                                            code: data['code'].toString(),
                                            name: data['name'].toString(),
                                            categoryId: int.parse(
                                                data['category_id'].toString()),
                                            backgroundColor:
                                                data['background_color']
                                                    .toString(),
                                            image: data['image'].toString(),
                                            qty: int.parse(
                                                data['qty'].toString()),
                                            size: double.parse(
                                                data['size'].toString()),
                                            description:
                                                data['description'].toString(),
                                            price: double.parse(
                                                data['price'].toString()),
                                            favorite: data['favorite'],
                                            varriantColors:
                                                data['varriant_colors']
                                                    as List),
                                      ));
                                },
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Hero(
                                            tag:
                                                '${data['name']}${data['code']}',
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: HexColor(
                                                      data['background_color']
                                                          .toString()),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          data['image']
                                                              .toString()))),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(data['name'].toString()),
                                            Text(data['code'].toString()),
                                          ],
                                        ),
                                        Text(
                                          '\$ ${data['price']}',
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {

                                              Get.to(
                                                () => AddEditProduct(
                                                  documentId: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id
                                                                  .toString(),
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
                                                      size: double.parse(
                                                          data['size']
                                                              .toString()),
                                                      description:
                                                          data['description']
                                                              .toString(),
                                                      price:
                                                          double.parse(data['price'].toString()),
                                                      favorite: data['favorite'],
                                                      varriantColors: data['varriant_colors'] as List),
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.edit_document)),
                                        IconButton(
                                            onPressed: () async {
                                              Get.defaultDialog(
                                                  title:
                                                      data['name'].toString(),
                                                  content: const Center(
                                                    child: Text(
                                                        'Are sure want to delete this product?'),
                                                  ),
                                                  actions: [
                                                    CupertinoButton(
                                                      color: Colors.red,
                                                      child:
                                                          const Text('Cancel'),
                                                      onPressed: () =>
                                                          Get.back(),
                                                    ),
                                                    CupertinoButton(
                                                        color: Colors.blue,
                                                        child: const Text(
                                                            'Confirm'),
                                                        onPressed: () async {
                                                          dataRefProducts
                                                              .doc(snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .id
                                                                  .toString())
                                                              .delete()
                                                              .then((value) =>
                                                                  Get.back());
                                                        })
                                                  ]);
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ))
                                  ],
                                )));
                      },
                    );
        },
      ),
    );
  }
}
