// class ProductModel{
//   static final products = [
//     Product(
//       id: "1",
//       name: "RAM Kingston KVR32S",
//       description: "DDR4-3200MHz",
//       price: 8900000,
//       quantity: 19,
//       branch: "All",
//       imgUrl: "https://images.fpt.shop/unsafe/fit-in/214x214/filters:quality(90):fill(white)/fptshop.com.vn/Uploads/Originals/2021/11/27/637736097183292342_ram-kingston-kvr32s22s8-8-8-gb-ddr4-3200-mhz-xanh-dd.jpg",
//     ),
//   ];
// }

// class Product {
//   final String id;
//   final String name;
//   final String description;
//   final double price;
//   final int quantity;
//   final String branch;
//   final String imgUrl;
//   Product({required this.id, required this.name, required this.description, required this.price, required this.quantity, required this.branch, required this.imgUrl});
// }

class Accessory {
  String? sId;
  String? name;
  String? description;
  String? insurance;
  SupplierId? supplierId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;
  ServiceId? serviceId;
  int? price;

  Accessory(
      {this.sId,
      this.name,
      this.description,
      this.insurance,
      this.supplierId,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.serviceId,
      this.price});

  Accessory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    insurance = json['insurance'];
    supplierId = json['supplier_id'] != null
        ? SupplierId.fromJson(json['supplier_id'])
        : null;
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    serviceId = json['service_id'] != null
        ? ServiceId.fromJson(json['service_id'])
        : null;
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['insurance'] = insurance;
    if (supplierId != null) {
      data['supplier_id'] = supplierId!.toJson();
    }
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    if (serviceId != null) {
      data['service_id'] = serviceId!.toJson();
    }
    data['price'] = price;
    return data;
  }
}

class SupplierId {
  String? sId;
  String? name;
  String? address;
  String? phonenum;
  List<String>? accessoriesId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SupplierId(
      {this.sId,
      this.name,
      this.address,
      this.phonenum,
      this.accessoriesId,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SupplierId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    address = json['address'];
    phonenum = json['phonenum'];
    accessoriesId = json['accessories_id'].cast<String>();
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['address'] = address;
    data['phonenum'] = phonenum;
    data['accessories_id'] = accessoriesId;
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class ServiceId {
  String? sId;
  String? name;
  int? price;
  String? description;
  String? type;
  bool? hasAccessory;
  List<String>? accessoriesId;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ServiceId(
      {this.sId,
      this.name,
      this.price,
      this.description,
      this.type,
      this.hasAccessory,
      this.accessoriesId,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ServiceId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    type = json['type'];
    hasAccessory = json['hasAccessory'];
    accessoriesId = json['accessories_id'].cast<String>();
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    data['description'] = description;
    data['type'] = type;
    data['hasAccessory'] = hasAccessory;
    data['accessories_id'] = accessoriesId;
    data['deleted'] = deleted;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
