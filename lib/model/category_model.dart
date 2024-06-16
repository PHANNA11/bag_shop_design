class CategoryModel {
  int? id;
  String? name;
  CategoryModel({required this.id, required this.name});
}

List<CategoryModel> categoryList = [
  CategoryModel(id: 0, name: 'All'),
  CategoryModel(id: 1, name: 'Hand Bag'),
  CategoryModel(id: 2, name: 'Jewellery'),
  CategoryModel(id: 3, name: 'Footwear'),
  CategoryModel(id: 4, name: 'Dreser'),
];
