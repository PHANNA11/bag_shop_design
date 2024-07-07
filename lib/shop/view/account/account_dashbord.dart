import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:shop_bags/shop/view/account/add_edit_product.dart';
import 'package:shop_bags/shop/view/account/view_product_list.dart';

class AccountDashBoard extends StatefulWidget {
  const AccountDashBoard({super.key});

  @override
  State<AccountDashBoard> createState() => _AccountDashBoardState();
}

String get titleKey => 'title';
String get iconKey => 'icon';
String get onClickKey => 'onClick';

class _AccountDashBoardState extends State<AccountDashBoard> {
  RxBool isViewGrid = true.obs;
  List listMenus = [
    {
      titleKey: 'add product',
      iconKey: Icons.add_shopping_cart,
    },
    {
      titleKey: 'view product',
      iconKey: Icons.list,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          actions: [
            Obx(() => IconButton(
                onPressed: () {
                  isViewGrid(!isViewGrid.value);
                },
                icon: Icon(
                  isViewGrid.value ? Icons.list : Icons.grid_3x3_sharp,
                  size: 30,
                )))
          ],
        ),
        body: Obx(
          () => GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: isViewGrid.value ? 2 : 1,
              mainAxisExtent: isViewGrid.value ? 250 : 100,
            ),
            itemCount: listMenus.length,
            itemBuilder: (context, index) {
              return isViewGrid.value
                  ? buildCardMenuGrid(
                      title: listMenus[index][titleKey],
                      icon: listMenus[index][iconKey],
                    )
                  : buildCardMenuList(
                      title: listMenus[index][titleKey],
                      icon: listMenus[index][iconKey],
                    );
            },
          ),
        ));
  }

  Widget buildCardMenuGrid({String? title, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          if (title == 'add product') {
            Get.to(() => AddEditProduct(
                  product: null,
                ));
          } else if (title == 'view product') {
            Get.to(() => const ViewProductList());
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              icon ?? Icons.insert_photo,
              size: 80,
            ),
            Text(
              (title ?? 'Add Product').tr.capitalize!,
              style: const TextStyle(fontSize: 20),
            )
          ]),
        ),
      ),
    );
  }

  Widget buildCardMenuList({String? title, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: () {
          if (title == 'add product') {
            Get.to(() => AddEditProduct(
                  product: null,
                ));
          } else if (title == 'view product') {
            Get.to(() => const ViewProductList());
          }
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            Flexible(
              child: Icon(
                icon ?? Icons.insert_photo,
                size: 80,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                (title ?? 'Add Product').tr.capitalize!,
                style: const TextStyle(fontSize: 20),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
