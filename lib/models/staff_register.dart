class StaffRegister {
  String? date;
  int? slot;
  int? start;
  int? end;

  StaffRegister(String time, int slot, int start, int end);

  StaffRegister.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    slot = json['slot'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['slot'] = this.slot;
    data['start'] = this.start;
    data['end'] = this.end;
    return data;
  }
}
