class AppointmentModel{
  static final items = [
    Item(
      id: "1",
      uName: "Manh",
      description: "Sửa bản lề",
      status: "Chờ xác nhận",
      time: "13:00 - 26/6/2022",
    ),
    Item(
      id: "2",
      uName: "Manh",
      description: "Vệ sinh máy",
      status: "Đã xác nhận",
      time: "11:00 - 25/6/2022",
    ),
    Item(
      id: "3",
      uName: "Manh",
      description: "Thay màn hình",
      status: "Đã hoàn thành",
      time: "9:00 - 20/6/2022",
    ),
  ];
}

class Item {
  final String id;
  final String uName;
  final String description;
  final String status;
  final String time;

  Item({required this.id, required this.uName, required this.description, required this.status, required this.time});
}
