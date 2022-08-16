
class ServiceList {
  List<ServiceHasAcc>? serviceHasAcc;
  List<ServiceNoAcc>? serviceNoAcc;

  ServiceList({this.serviceHasAcc, this.serviceNoAcc});

  ServiceList.fromJson(Map<String, dynamic> json) {
    if(json["serviceHasAcc"] is List)
      this.serviceHasAcc = json["serviceHasAcc"]==null ? null : (json["serviceHasAcc"] as List).map((e)=>ServiceHasAcc.fromJson(e)).toList();
    if(json["serviceNoAcc"] is List)
      this.serviceNoAcc = json["serviceNoAcc"]==null ? null : (json["serviceNoAcc"] as List).map((e)=>ServiceNoAcc.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.serviceHasAcc != null)
      data["serviceHasAcc"] = this.serviceHasAcc?.map((e)=>e.toJson()).toList();
    if(this.serviceNoAcc != null)
      data["serviceNoAcc"] = this.serviceNoAcc?.map((e)=>e.toJson()).toList();
    return data;
  }
}

class ServiceNoAcc {
  String? id;
  String? name;
  String? description;
  String? type;
  int? price;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? v;
  bool? hasAccessory;
  List<String>? orderdetailId;

  ServiceNoAcc({this.id, this.name, this.description, this.type, this.price, this.deleted, this.createdAt, this.updatedAt, this.v, this.hasAccessory, this.orderdetailId});

  ServiceNoAcc.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String)
      this.id = json["_id"];
    if(json["name"] is String)
      this.name = json["name"];
    if(json["description"] is String)
      this.description = json["description"];
    if(json["type"] is String)
      this.type = json["type"];
    if(json["price"] is int)
      this.price = json["price"];
    if(json["deleted"] is bool)
      this.deleted = json["deleted"];
    if(json["createdAt"] is String)
      this.createdAt = json["createdAt"];
    if(json["updatedAt"] is String)
      this.updatedAt = json["updatedAt"];
    if(json["__v"] is int)
      this.v = json["__v"];
    if(json["hasAccessory"] is bool)
      this.hasAccessory = json["hasAccessory"];
    if(json["orderdetail_id"] is List)
      this.orderdetailId = json["orderdetail_id"]==null ? null : List<String>.from(json["orderdetail_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.id;
    data["name"] = this.name;
    data["description"] = this.description;
    data["type"] = this.type;
    data["price"] = this.price;
    data["deleted"] = this.deleted;
    data["createdAt"] = this.createdAt;
    data["updatedAt"] = this.updatedAt;
    data["__v"] = this.v;
    data["hasAccessory"] = this.hasAccessory;
    if(this.orderdetailId != null)
      data["orderdetail_id"] = this.orderdetailId;
    return data;
  }
}

class ServiceHasAcc {
  String? name;
  String? description;
  String? type;
  List<AccessoriesDetail>? accessoriesDetail;
  int? price;

  ServiceHasAcc({this.name, this.description, this.type, this.accessoriesDetail, this.price});

  ServiceHasAcc.fromJson(Map<String, dynamic> json) {
    if(json["name"] is String)
      this.name = json["name"];
    if(json["description"] is String)
      this.description = json["description"];
    if(json["type"] is String)
      this.type = json["type"];
    if(json["accessories_detail"] is List)
      this.accessoriesDetail = json["accessories_detail"]==null ? null : (json["accessories_detail"] as List).map((e)=>AccessoriesDetail.fromJson(e)).toList();
    if(json["price"] is int)
      this.price = json["price"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.name;
    data["description"] = this.description;
    data["type"] = this.type;
    if(this.accessoriesDetail != null)
      data["accessories_detail"] = this.accessoriesDetail?.map((e)=>e.toJson()).toList();
    data["price"] = this.price;
    return data;
  }
}

class AccessoriesDetail {
  String? id;
  String? name;
  String? description;
  String? insurance;

  AccessoriesDetail({this.id, this.name, this.description, this.insurance});

  AccessoriesDetail.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String)
      this.id = json["_id"];
    if(json["name"] is String)
      this.name = json["name"];
    if(json["description"] is String)
      this.description = json["description"];
    if(json["insurance"] is String)
      this.insurance = json["insurance"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.id;
    data["name"] = this.name;
    data["description"] = this.description;
    data["insurance"] = this.insurance;
    return data;
  }
}