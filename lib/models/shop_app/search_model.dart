class SearchModel {
  late bool status;
  late DataModel data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<Data> data = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    json['data'].map((e) {
      e = Data.fromJson(e);
      data.add(e);
    }).toList();
  }
}

class Data {
  late int id;
  dynamic price;
  late String image;
  late String name;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
  }
}
