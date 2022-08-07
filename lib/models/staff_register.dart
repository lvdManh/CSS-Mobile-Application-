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
