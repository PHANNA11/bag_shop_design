class ProductModel {
  String? code;
  String? name;
  double? price;
  String? image;
  double? size;
  String? description;
  int? categoryId;
  bool? favorite;
  int? qty;
  String? backgroundColor;
  List<String>? varriantColors;
  ProductModel({
    this.code,
    this.name,
    this.price,
    this.image,
    this.size,
    this.categoryId,
    this.description,
    this.favorite,
    this.qty,
    this.varriantColors,
    this.backgroundColor,
  });
}

List<ProductModel> productList = [
  ProductModel(
    name: 'Lv Bag',
    categoryId: 1,
    price: 1200,
    backgroundColor: '#2b6891',
    image: 'assets/images/bag_1.png',
    favorite: false,
    qty: 0,
    size: 12,
    description: 'dsdfghjkllkjhgfdhjk',
    code: 'A12',
    varriantColors: ['#6495ED', '#2874A6', '#616A6B'],
  ),
  ProductModel(
    name: 'Lv Bag2',
    categoryId: 1,
    price: 1200,
    backgroundColor: '#73C6B6',
    image: 'assets/images/bag_2.png',
    favorite: false,
    qty: 0,
    size: 12,
    description: 'dsdfghjkllkjhgfdhjk',
    code: 'A112',
    varriantColors: ['#2b6891', '#2874A6', '#616A6B'],
  ),
  ProductModel(
    name: 'Lv Bag32',
    categoryId: 4,
    price: 1200,
    image: 'assets/images/bag_3.png',
    favorite: false,
    qty: 0,
    backgroundColor: '#F0B27A',
    size: 12,
    description: 'dsdfghjkllkjhgfdhjk',
    code: 'B43',
    varriantColors: ['#6495ED', '#2874A6', '#616A6B'],
  ),
  ProductModel(
    name: 'Channel Bag',
    categoryId: 3,
    price: 1200,
    image: 'assets/images/bag_4.png',
    favorite: false,
    qty: 0,
    size: 12,
    backgroundColor: '#F0B27A',
    description: 'dsdfghjkllkjhgfdhjk',
    code: 'A87',
    varriantColors: ['#6495ED', '#2874A6', '#616A6B'],
  ),
  ProductModel(
    name: 'Lv Baghgf',
    categoryId: 2,
    price: 1200,
    image: 'assets/images/bag_5.png',
    favorite: false,
    qty: 0,
    size: 12,
    backgroundColor: '#e28890',
    description: 'dsdfghjkllkjhgfdhjk',
    code: 'C44',
    varriantColors: ['#6495ED', '#2874A6', '#616A6B'],
  ),
  ProductModel(
    name: 'Lv Bag23',
    categoryId: 3,
    price: 1200,
    image: 'assets/images/bag_6.png',
    favorite: false,
    qty: 0,
    backgroundColor: '#F0B27A',
    size: 12,
    description: 'dsdfghjkllkjhgfdhjk',
    code: 'D12',
    varriantColors: ['#6495ED', '#2874A6', '#616A6B'],
  ),
];
