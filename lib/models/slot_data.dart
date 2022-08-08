class Slot {
  Slot({
    required this.id,
    required this.date,
    required this.slots,
    required this.status,
  });
  late final String id;
  late final String date;
  late final List<Slots> slots;
  late final String status;

  Slot.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    date = json['date'];
    slots = List.from(json['slots']).map((e)=>Slots.fromJson(e)).toList();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['date'] = date;
    data['slots'] = slots.map((e)=>e.toJson()).toList();
    data['status'] = status;

    return data;
  }
}

class Slots {
  Slots({
    required this.id,
    required this.slot,
    required this.start,
    required this.end,
    required this.status,
    required this.workSlot,
    required this.scheduleId,
  });
  late final String id;
  late final int slot;
  late final int start;
  late final int end;
  late final String status;
  late final List<String> workSlot;
  late final String scheduleId;

  Slots.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    slot = json['slot'];
    start = json['start'];
    end = json['end'];
    status = json['status'];
    workSlot = List.castFrom<dynamic, String>(json['work_slot']);
    scheduleId = json['schedule_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['slot'] = slot;
    data['start'] = start;
    data['end'] = end;
    data['status'] = status;
    data['work_slot'] = workSlot;
    data['schedule_id'] = scheduleId;

    return data;
  }
}