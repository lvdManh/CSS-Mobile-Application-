
class WorkSchedule {
  String? id;
  String? date;
  List<Slots>? slots;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;

  WorkSchedule({this.id, this.date, this.slots, this.status, this.createdAt, this.updatedAt, this.v});

  WorkSchedule.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["date"] is String) {
      date = json["date"];
    }
    if(json["slots"] is List) {
      slots = json["slots"]==null ? null : (json["slots"] as List).map((e)=>Slots.fromJson(e)).toList();
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if(json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if(json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["date"] = date;
    if(slots != null) {
      data["slots"] = slots?.map((e)=>e.toJson()).toList();
    }
    data["status"] = status;
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    return data;
  }
}

class Slots {
  String? id;
  int? slot;
  int? start;
  int? end;
  int? maxPer;
  String? status;
  List<WorkSlot>? workSlot;

  Slots({this.id, this.slot, this.start, this.end, this.maxPer, this.status, this.workSlot});

  Slots.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["slot"] is int) {
      slot = json["slot"];
    }
    if(json["start"] is int) {
      start = json["start"];
    }
    if(json["end"] is int) {
      end = json["end"];
    }
    if(json["max_per"] is int) {
      maxPer = json["max_per"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
    if(json["work_slot"] is List) {
      workSlot = json["work_slot"]==null ? null : (json["work_slot"] as List).map((e)=>WorkSlot.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["slot"] = slot;
    data["start"] = start;
    data["end"] = end;
    data["max_per"] = maxPer;
    data["status"] = status;
    if(workSlot != null) {
      data["work_slot"] = workSlot?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class WorkSlot {
  String? id;
  StaffId? staffId;

  WorkSlot({this.id, this.staffId});

  WorkSlot.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["staff_id"] is Map) {
      staffId = json["staff_id"] == null ? null : StaffId.fromJson(json["staff_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if(staffId != null) {
      data["staff_id"] = staffId?.toJson();
    }
    return data;
  }
}

class StaffId {
  String? id;
  UserId? userId;

  StaffId({this.id, this.userId});

  StaffId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["user_id"] is Map) {
      userId = json["user_id"] == null ? null : UserId.fromJson(json["user_id"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    if(userId != null) {
      data["user_id"] = userId?.toJson();
    }
    return data;
  }
}

class UserId {
  String? id;
  String? name;
  String? email;
  String? phonenum;
  String? birth;

  UserId({ this.id, this.name, this.email, this.phonenum, this.birth});

  UserId.fromJson(Map<String, dynamic> json) {
    if(json["_id"] is String) {
      id = json["_id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["phonenum"] is String) {
      phonenum = json["phonenum"];
    }
    if(json["birth"] is String) {
      birth = json["birth"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phonenum"] = phonenum;
    data["birth"] = birth;
    return data;
  }
}
