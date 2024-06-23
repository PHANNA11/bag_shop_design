import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_bags/controller/product_cart_controller.dart';
import 'package:shop_bags/model/product_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shop_bags/view/cart_list_screen.dart';

class DetailProductScreen extends StatefulWidget {
  DetailProductScreen({super.key, required this.product});
  ProductModel? product;
  int qty = 1;

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {
  RxString selectedVarriant = ''.obs;
  bool isFavorite = false;
  final productCartController = Get.put(ProductCartController());
  @override
  void initState() {
    // TODO: implement initState
    selectedVarriant = widget.product!.varriantColors!.first.toString().obs;
    isFavorite = widget.product!.favorite!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<ProductCartController>(
        init: productCartController,
        builder: (context) {
          return Scaffold(
            backgroundColor:
                HexColor(widget.product!.backgroundColor.toString()),
            appBar: AppBar(
              backgroundColor:
                  HexColor(widget.product!.backgroundColor.toString()),
              //foregroundColor: Colors.black,
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
                      badgeContent: Text(
                          productCartController.cartList.length.toString()),
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
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Column(children: [
                        Text(widget.product!.name.toString()),
                        Text(
                          'Code : ${widget.product!.name}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                      height: 70,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Colors',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Obx(() => Row(
                                                children: List.generate(
                                                    widget.product!
                                                        .varriantColors!.length,
                                                    (index) => GestureDetector(
                                                          onTap: () {
                                                            selectedVarriant(widget
                                                                .product!
                                                                .varriantColors![
                                                                    index]
                                                                .toString());
                                                          },
                                                          child: Icon(
                                                            selectedVarriant
                                                                        .value ==
                                                                    widget
                                                                        .product!
                                                                        .varriantColors![
                                                                            index]
                                                                        .toString()
                                                                ? Icons
                                                                    .radio_button_checked
                                                                : Icons.circle,
                                                            size: 30,
                                                            color: HexColor(widget
                                                                .product!
                                                                .varriantColors![
                                                                    index]
                                                                .toString()),
                                                          ),
                                                        )),
                                              ))
                                        ],
                                      ),
                                    )),
                                    SizedBox(
                                      height: 70,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Size',
                                          ),
                                          Text(
                                            '${widget.product!.size} cm',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Text(widget.product!.description.toString()),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (widget.qty > 1) {
                                              setState(() {
                                                widget.qty--;
                                              });
                                            }
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: HexColor(widget
                                                        .product!
                                                        .backgroundColor
                                                        .toString())),
                                                shape: BoxShape.circle),
                                            child: const Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              widget.qty.toString(),
                                              style:
                                                  const TextStyle(fontSize: 22),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              widget.qty++;
                                            });
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: HexColor(widget
                                                        .product!
                                                        .backgroundColor
                                                        .toString())),
                                                shape: BoxShape.circle),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: !isFavorite
                                                    ? HexColor(widget.product!
                                                        .backgroundColor
                                                        .toString())
                                                    : Colors.red),
                                            color: isFavorite
                                                ? Colors.red
                                                : Colors.white,
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Icon(
                                            Icons.favorite,
                                            color: isFavorite
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                    top: height / 5 - 10,
                    right: width / 5 - 40,
                    child: Hero(
                      tag: '${widget.product!.name}${widget.product!.code}',
                      child: Image(
                          height: 200,
                          width: 200,
                          fit: BoxFit.scaleDown,
                          image: AssetImage(widget.product!.image.toString())),
                    ))
              ],
            ),
            bottomNavigationBar: Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          widget.product!.qty = widget.qty;
                          productCartController.addToCart(
                              product: widget.product!);
                        },
                        child: Container(
                          width: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: HexColor(widget.product!.backgroundColor
                                    .toString())),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.shopping_cart,
                              color: HexColor(
                                  widget.product!.backgroundColor.toString()),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: HexColor(
                                widget.product!.backgroundColor.toString(),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'buy now'.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
