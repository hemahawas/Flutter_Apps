class FavoritesModel {
  late bool status;
  String? message;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic>? json) {
    status = json?['status'];
    message = json?['message'];
    data = Data.fromJson(json?['data']);
  }
}

class Data {
  late int? currentPage;
  late List<FavoritesData> FavData = [];
  late String? firstPageUrl;
  late int? from;
  late int? lastPage;
  late String? lastPageUrl;
  late String? nextPageUrl;
  late String path;
  late int? perPage;
  late String? prevPageUrl;
  late int? to;
  late int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].map((e) {
      e = FavoritesData.fromJson(e);
      FavData.add(e);
    }).toList();

    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoritesData {
  late int? id;
  late Product product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  late int? id;
  late int? price;
  late int? oldPrice;
  late int? discount;
  late String image;
  late String name;
  late String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
