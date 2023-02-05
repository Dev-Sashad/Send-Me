class CarsData {
  List<Cars>? cars;
  CarsData({this.cars});
  CarsData.fromJson(Map<String, dynamic> json) {
    if (json['cars'] != null) {
      cars = <Cars>[];
      json['cars'].forEach((v) {
        cars!.add(Cars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cars != null) {
      data['cars'] = cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cars {
  int? id;
  String? uid;
  String? brand;
  String? model;
  String? year;
  String? vehicleType;
  String? coverImage;

  Cars({
    this.id,
    this.uid,
    this.brand,
    this.model,
    this.year,
    this.vehicleType,
    this.coverImage,
  });

  Cars.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    brand = json['brand'];
    model = json['model'];
    year = json['year'];
    vehicleType = json['vehicleType'];
    coverImage = json['coverImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['brand'] = brand;
    data['model'] = model;
    data['year'] = year;
    data['vehicleType'] = vehicleType;
    data['coverImage'] = coverImage;
    return data;
  }
}
