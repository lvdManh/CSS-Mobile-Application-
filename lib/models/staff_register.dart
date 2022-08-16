
class ListScheduleRegister{
  List<StaffRegister>? datas;
  ListScheduleRegister({this.datas});
  ListScheduleRegister.fromJson(Map<String, dynamic> json){
    if(json["datas"] is List) {
      datas = json["datas"] == null ? null : (json["datas"] as List).map((e)=>StaffRegister.fromJson(e)).toList();
    }
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if(datas != null) {
      data["datas"] = datas?.map((e)=>e.toJson()).toList();
    }
    return data;
  }
}

class StaffRegister {
  String? date;
  int? slot;
  int? start;
  int? end;

  StaffRegister({this.date, this.slot, this.start, this.end});

  StaffRegister.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    slot = json['slot'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['slot'] = slot;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}
