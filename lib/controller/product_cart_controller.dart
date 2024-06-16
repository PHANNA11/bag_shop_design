import 'package:get/get.dart';
import 'package:shop_bags/model/product_model.dart';

class ProductCartController extends GetxController {
  RxList<ProductModel> cartList = <ProductModel>[].obs;
  void addToCart({required ProductModel product}) {
    cartList.add(product);
    update();
  }
}
