import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/features/registing_work.dart';
import 'package:computer_service_system/models/staff_register.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/color_constant.dart';

class StaffRegistWork extends StatefulWidget {
  static const String routeName = '/staff_regist_work';
  const StaffRegistWork({Key? key}) : super(key: key);
  @override
  State<StaffRegistWork> createState() => _StaffRegistWorkState();
}

class _StaffRegistWorkState extends State<StaffRegistWork> {
  int _selectedItemIndex = 1;
  bool isChecked = false;

  late ScheduleDataSource scheduleDataSource;
  List<Schedule> schedules = [];
  List<StaffRegister> list = [];
  List<String> nextTwoWeek = [];

  List<String> weekday() {
    var nextWeekDay = DateTime.now().add(const Duration(days: 14));
    var startFrom = nextWeekDay.subtract(Duration(days: nextWeekDay.weekday));
    nextTwoWeek =
        List.generate(7, (i) => '${startFrom.add(Duration(days: i))}');

    return nextTwoWeek;
  }

  @override
  void initState() {
    weekday();
    super.initState();

    schedules = getScheduleData(nextTwoWeek);
    scheduleDataSource = ScheduleDataSource(scheduleData: schedules);
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
    return Scaffold(
      //App Bar
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.orangeAccent,
        title: const Text(
          "Computer Services",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(color: mBackgroundColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                  child: Text('Đăng ký lịch làm việc',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ))),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 140),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(parseDay(nextTwoWeek.first),
                            style: const TextStyle(
                                fontSize: 24, fontFamily: 'Regular')),
                        Text(parseDay(nextTwoWeek.last),
                            style: const TextStyle(
                                fontSize: 24, fontFamily: 'Regular')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: SfDataGrid(
                  source: scheduleDataSource,
                  columns: <GridColumn>[
                    GridColumn(
                        columnName: 'date',
                        width: 60,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Ngày',
                            ))),
                    GridColumn(
                        columnName: 'slot1',
                        width: 90,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text('8:00-11:00'))),
                    GridColumn(
                        columnName: 'slot2',
                        width: 90,
                        label: Container(
                            alignment: Alignment.center,
                            child: const Text('11:00-14:00'))),
                    GridColumn(
                        columnName: 'slot3',
                        width: 90,
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text('14:00-17:00'),
                        )),
                    GridColumn(
                        columnName: 'slot4',
                        width: 90,
                        label: Container(
                          alignment: Alignment.center,
                          child: const Text('17:00-20:00'),
                        )),
                  ],
                ),
              ),
              Container(
                width: 150,
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                    text: 'Đăng ký',
                    onTap: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.QUESTION,
                        title: 'Xác nhận đăng ký lịch?',
                        dismissOnTouchOutside: false,
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          list = getScheduleDataOfEachDay(schedules);
                          checkAndPostSchedule(list, token, context);
                        },
                      ).show();
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      // Bottom Navigation----------------
      bottomNavigationBar: Row(
        children: <Widget>[
          buildNavBarItem(Icons.home, 0),
          buildNavBarItem(Icons.list_alt, 1),
          buildNavBarItem(Icons.notifications, 2),
          buildNavBarItem(Icons.person, 3)
        ],
      ),
      // This is Background Color
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width / 4,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border: const Border(
                  bottom: BorderSide(width: 4, color: Colors.orangeAccent),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.3),
                    Colors.white.withOpacity(0.015),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ))
            : const BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Colors.redAccent : Colors.white,
        ),
      ),
    );
  }
}

String parseDay(time) {
  DateTime dt1 = DateTime.parse(time);
  return '${dt1.day}/${dt1.month}';
}

String requestDate(time) {
  DateTime dt1 = DateTime.parse(time);
  return '${dt1.year}-${dt1.month}-${dt1.day}';
}

List<Schedule> getScheduleData(List listDay) {
  return [
    for (int i = 0; i < listDay.length; i++)
      Schedule(listDay[i], false, false, false, false)
  ];
}

List<StaffRegister> getScheduleDataOfEachDay(List<Schedule> schedule) {
  List<StaffRegister> list = [];
  for (int i = 0; i < schedule.length; i++) {
    String time = schedule[i].time;
    if (schedule[i].check1) {
      final eachSchedule1 =
          StaffRegister(date: requestDate(time), slot: 1, start: 800, end: 930);
      list.add(eachSchedule1);
      final eachSchedule2 = StaffRegister(
          date: requestDate(time), slot: 2, start: 930, end: 1100);
      list.add(eachSchedule2);
    }

    if (schedule[i].check2) {
      final eachSchedule1 = StaffRegister(
          date: requestDate(time), slot: 3, start: 1100, end: 1230);
      list.add(eachSchedule1);
      final eachSchedule2 = StaffRegister(
          date: requestDate(time), slot: 4, start: 1230, end: 1400);
      list.add(eachSchedule2);
    }

    if (schedule[i].check3) {
      final eachSchedule1 = StaffRegister(
          date: requestDate(time), slot: 5, start: 1400, end: 1530);
      list.add(eachSchedule1);
      final eachSchedule2 = StaffRegister(
          date: requestDate(time), slot: 6, start: 1530, end: 1700);
      list.add(eachSchedule2);
    }

    if (schedule[i].check4) {
      final eachSchedule1 = StaffRegister(
          date: requestDate(time), slot: 7, start: 1700, end: 1830);
      list.add(eachSchedule1);
      final eachSchedule2 = StaffRegister(
          date: requestDate(time), slot: 8, start: 1830, end: 2000);
      list.add(eachSchedule2);
    }
  }
  return list;
}

checkAndPostSchedule(List<StaffRegister> list, token, context) async {
  StaffAssignWorkSchedule().addSchedule(context, token, list);
}

class Schedule {
  Schedule(this.time, this.check1, this.check2, this.check3, this.check4);
  final String time;
  bool check1;
  bool check2;
  bool check3;
  bool check4;
}

class ScheduleDataSource extends DataGridSource {
  ScheduleDataSource({required this.scheduleData}) {
    updateDataGridRow();
  }

  List<DataGridRow> _dataGridRow = [];
  List<Schedule> scheduleData = [];

  void updateDataGridRow() {
    _dataGridRow = scheduleData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'date', value: parseDay(e.time)),
              DataGridCell(columnName: 'slot1', value: e.check1),
              DataGridCell(columnName: 'slot2', value: e.check2),
              DataGridCell(columnName: 'slot3', value: e.check3),
              DataGridCell(columnName: 'slot4', value: e.check4),
            ]))
        .toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRow;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        // padding: EdgeInsets.symmetric(horizontal: 16),
        child: Text(row.getCells()[0].value.toString()),
      ),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[1].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check1 = value!;
              row.getCells()[1] =
                  DataGridCell(value: value, columnName: 'slot1');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 1));
            },
          )),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[2].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check2 = value!;
              row.getCells()[2] =
                  DataGridCell(value: value, columnName: 'slot2');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 2));
            },
          )),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[3].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check3 = value!;
              row.getCells()[3] =
                  DataGridCell(value: value, columnName: 'slot3');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 3));
            },
          )),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[4].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check4 = value!;
              row.getCells()[4] =
                  DataGridCell(value: value, columnName: 'slot4');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 4));
            },
          )),
    ]);
  }
}
