import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../custom/dialog/loading.dart';
import '../../../custom/widget/text_field_widget.dart';
import '../../firebase/module/firebase_storage.dart';
import '../../model/product_model.dart';

class AddEditProduct extends StatefulWidget {
  AddEditProduct({super.key, this.product, this.documentId});
  ProductModel? product;
  String? documentId;

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  CollectionReference dataRefProducts =
      FirebaseFirestore.instance.collection('Products');
  CollectionReference dataRefCategory =
      FirebaseFirestore.instance.collection('Categorys');
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final priceController = TextEditingController();
  final bgColorController = TextEditingController();
  final detailController = TextEditingController();
  final sizeController = TextEditingController();
  final categoryIdController = TextEditingController();
  final discountController = TextEditingController();
  final sellPriceController = TextEditingController();
  final linkImageController = TextEditingController();
  final discountLabelController = TextEditingController();

  // test
  final testlinkImageController = TextEditingController();
  // File? fileImage;
  void initProduct() {
    setState(() {
      nameController.text = widget.product!.name.toString();
      codeController.text = widget.product!.code.toString();
      priceController.text = widget.product!.price.toString();
      bgColorController.text = widget.product!.backgroundColor.toString();
      detailController.text = widget.product!.description.toString();
      sizeController.text = widget.product!.size.toString();
      categoryIdController.text = widget.product!.categoryId.toString();

      linkImageController.text = widget.product!.image.toString();
    });
  }

  void clear() {
    nameController.text = "";
    codeController.text = "";
    priceController.text = "";
    bgColorController.text = "";
    detailController.text = "";
    sizeController.text = "";
    categoryIdController.text = "";

    linkImageController.text = '';
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.product != null) {
      initProduct();
    } else {
      clear();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? 'Edit Product' : 'Add product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldWidget(
              hindText: 'product Code',
              controller: codeController,
            ),
            TextFieldWidget(
              hindText: 'product Name',
              controller: nameController,
            ),
            TextFieldWidget(
              sufficIconData: Icons.currency_exchange,
              controller: priceController,
              hindText: 'product Price',
              keyboardType: TextInputType.number,
            ),
            TextFieldWidget(
              controller: detailController,
              hindText: 'product Detail',
            ),
            TextFieldWidget(
              controller: sizeController,
              hindText: 'product Size',
              keyboardType: TextInputType.number,
            ),
            TextFieldWidget(
              controller: categoryIdController,
              hindText: 'product Category',
              keyboardType: TextInputType.number,
            ),
            // TextFieldWidget(
            //   readOnly: true,
            //   sufficIconData: Icons.percent,
            //   controller: discountController,
            //   hindText: 'product discount %',
            //   onChanged: (p0) {
            //     if (priceController.text.isNotEmpty) {
            //       setState(() {
            //         sellPriceController
            //             .text = (double.parse(priceController.text) -
            //                 (double.parse(priceController.text) *
            //                     (double.parse(discountController.text) / 100)))
            //             .toString();
            //       });
            //     }
            //   },
            // ),
            // TextFieldWidget(
            //   controller: discountLabelController,
            //   hindText: 'Discount Label',
            // ),
            // TextFieldWidget(
            //   sufficIconData: Icons.currency_exchange,
            //   controller: sellPriceController,
            //   readOnly: true,
            //   hindText: 'product sell Price',
            // ),
            TextFieldWidget(
              controller: bgColorController,
              hindText: 'Background Colors',
            ),
            TextFieldWidget(
              controller: linkImageController,
              hindText: 'product image link',
              onChanged: (p0) {
                setState(() {
                  linkImageController.text = p0;
                });
              },
            ),
            GestureDetector(
              onTap: () async {
                Get.bottomSheet(
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await FireBaseStorageController().openCamera() ?? '';
                          setState(() {
                            linkImageController.text = selectImage.value;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 208, 189, 21),
                          ),
                          child: const Center(
                            child: Text(
                              'Camera',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await FireBaseStorageController().openGallary() ?? '';
                          setState(() {
                            linkImageController.text = selectImage.value;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(255, 208, 189, 21),
                          ),
                          child: const Center(
                            child: Text(
                              'Gallary',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                );
                // await ProductFireBase().addProduct(
                //   ProductModel(
                //     id: DateTime.now().microsecondsSinceEpoch,
                //     name: nameController.text,
                //     price: double.parse(priceController.text),
                //     discription: detailController.text,
                //     discount: double.parse(discountController.text),
                //     discountLabel: discountLabelController.text,
                //     sellPrice: double.parse(sellPriceController.text),
                //     image: linkImageController.text,
                //   ),
                // );
              },
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 138, 181, 215),
                ),
                child: const Center(
                  child: Text(
                    'Select Image',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            linkImageController.text.isEmpty
                ? const SizedBox()
                : Stack(
                    children: [
                      Image(
                        height: 200,
                        width: 200,
                        image: NetworkImage(linkImageController.text),
                      ),
                      Positioned(
                          top: -10,
                          right: -10,
                          child: IconButton(
                              onPressed: () async {
                                await FireBaseStorageController().deleteImage(
                                    imageUrl: linkImageController.text);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )))
                    ],
                  ),
            // TextFieldWidget(
            //   controller: testlinkImageController,
            //   hindText: 'Image Name',
            // ),
            // CupertinoButton(
            //   color: Colors.blue,
            //   child: const Text('Request Image'),
            //   onPressed: () async {
            //     await FirebaseStorage.instance
            //         .ref()
            //         .child('/image')
            //         .child('/${testlinkImageController.text}')
            //         .getDownloadURL()
            //         .then((value) {
            //       setState(() {
            //         linkImageController.text = value;
            //         log(value.toString());
            //       });
            //     });
            //   },
            // )
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          openLoading();
          Map<String, dynamic> pro = {
            'code': codeController.text,
            'name': nameController.text,
            'price': double.parse(priceController.text),
            'image': linkImageController.text.trim(),
            'category_id': int.parse(categoryIdController.text),
            'description': detailController.text,
            'size': double.parse(sizeController.text),
            'qty': 0,
            'favorite': false,
            'background_color': bgColorController.text.isEmpty
                ? '#6495ED'
                : bgColorController.text,
            'varriant_colors': ["#6495ED", "#2874A6", "#616A6B"],
          };
          if (widget.product != null && widget.documentId != null) {
            await dataRefProducts
                .doc(widget.documentId)
                .set(pro)
                .whenComplete(() => closeLoading());
          } else {
            await dataRefProducts.add(pro).whenComplete(() => closeLoading());
          }

          // if (widget.productModel == null) {
          //   await ProductFireBase().addProduct(
          //     ProductModel(
          //       id: DateTime.now().microsecondsSinceEpoch,
          //       name: nameController.text,
          //       price: double.parse(priceController.text),
          //       discription: detailController.text,
          //       discount: double.parse(discountController.text),
          //       discountLabel: discountLabelController.text,
          //       sellPrice: double.parse(sellPriceController.text),
          //       image: linkImageController.text,
          //     ),
          //   );
          // } else {
          //   await FireBaseStorageController()
          //       .deleteImage(imageUrl: widget.productModel!.image!);
          //   await ProductFireBase().updateProduct(
          //     docId: widget.docId!,
          //     product: ProductModel(
          //       id: widget.productModel!.id,
          //       name: nameController.text,
          //       price: double.parse(priceController.text),
          //       discription: detailController.text,
          //       discount: double.parse(discountController.text),
          //       discountLabel: discountLabelController.text,
          //       sellPrice: double.parse(sellPriceController.text),
          //       image: linkImageController.text,
          //     ),
          //   );
          // }

          Get.back();
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 208, 189, 21),
          ),
          child: const Center(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
