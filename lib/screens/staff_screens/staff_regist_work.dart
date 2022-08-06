import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/features/registing_work.dart';
import 'package:computer_service_system/models/staff_register.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class StaffRegistWork extends StatefulWidget {
  static const String routeName = '/staff_regist_work';
  const StaffRegistWork({Key? key}) : super(key: key);
  @override
  State<StaffRegistWork> createState() => _StaffRegistWorkState();
}

class _StaffRegistWorkState extends State<StaffRegistWork> {
  int _selectedItemIndex = 1;
  bool isChecked = false;
  final StaffRegistingWorkService staffRegistingWorkServices =
      StaffRegistingWorkService();

  late ScheduleDataSource scheduleDataSource;
  List<Schedule> schedules = <Schedule>[];
  List<StaffRegister> list = [];

  @override
  void initState() {
    super.initState();
    schedules = getScheduleData();
    scheduleDataSource = ScheduleDataSource(scheduleData: schedules);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<DataClass>(context, listen: false);
    return Scaffold(
      //App Bar
      backgroundColor: Colors.white,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
              padding: EdgeInsets.fromLTRB(50, 20, 20, 20),
              //mã hóa đơn
              child: Text('Đăng ký lịch làm việc',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ))),
          SfDataGrid(
            source: scheduleDataSource,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'date',
                  width: 110,
                  label: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        'Ngày',
                      ))),
              GridColumn(
                  columnName: 'slot1',
                  width: 110,
                  label: Container(
                      alignment: Alignment.center,
                      child: const Text('8:00-9:30'))),
              GridColumn(
                  columnName: 'slot2',
                  width: 110,
                  label: Container(
                      alignment: Alignment.center,
                      child: const Text('9:30-11:00'))),
              GridColumn(
                  columnName: 'slot3',
                  width: 110,
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('11:00-12:30'),
                  )),
              GridColumn(
                  columnName: 'slot4',
                  width: 110,
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('12:30-14:00'),
                  )),
              GridColumn(
                  columnName: 'slot5',
                  width: 110,
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('14:00-15:30'),
                  )),
              GridColumn(
                  columnName: 'slot6',
                  width: 110,
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('15:30-17:00'),
                  )),
              GridColumn(
                  columnName: 'slot7',
                  width: 110,
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('17:00-18:30'),
                  )),
              GridColumn(
                  columnName: 'slot8',
                  width: 110,
                  label: Container(
                    alignment: Alignment.center,
                    child: const Text('18:30-20:00'),
                  )),
            ],
          ),
          Container(
            width: 140,
            padding: const EdgeInsets.all(15.0),
            // child: RaisedButton(
            //     color: Colors.white,
            //     child: Text(
            //       "Đăng ký",
            //       style: TextStyle(
            //         color: Colors.orange,
            //         fontSize: 20,
            //       ),
            //     ),
            //     onPressed: () {}),
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
                      print("-------");
                      print(list);
                    },
                  ).show();
                }),
          ),
        ],
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

List<Schedule> getScheduleData() {
  return [
    Schedule(
        '08/08/2022', false, false, false, false, false, false, false, false),
    Schedule(
        '09/08/2022', false, false, false, false, false, false, false, false),
    Schedule(
        '10/08/2022', false, false, false, false, false, false, false, false),
    Schedule(
        '11/08/2022', false, false, false, false, false, false, false, false),
    Schedule(
        '12/08/2022', false, false, false, false, false, false, false, false),
    Schedule(
        '13/08/2022', false, false, false, false, false, false, false, false),
    Schedule(
        '14/08/2022', false, false, false, false, false, false, false, false),
  ];
}

List<StaffRegister> getScheduleDataOfEachDay(List<Schedule> schedule) {
  List<StaffRegister> list = [];
  int slot;
  int start;
  int end;
  String time = schedule[0].time;
  for (int i = 0; i < schedule.length; i++) {
    if (schedule[i].check1 == true) {
      slot = 1;
      start = 800;
      end = 930;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }

    if (schedule[i].check2 == true) {
      slot = 2;
      start = 930;
      end = 1100;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }

    if (schedule[i].check3 == true) {
      slot = 3;
      start = 1100;
      end = 1230;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }

    if (schedule[i].check4 == true) {
      slot = 4;
      start = 1230;
      end = 1400;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }

    if (schedule[i].check5 == true) {
      slot = 5;
      start = 1400;
      end = 1530;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }

    if (schedule[i].check6 == true) {
      slot = 6;
      start = 1530;
      end = 1700;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }

    if (schedule[i].check7 == true) {
      slot = 7;
      start = 1700;
      end = 1830;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }

    if (schedule[i].check8 == true) {
      slot = 8;
      start = 1830;
      end = 2000;
      StaffRegister eachSchedule = new StaffRegister(time, slot, start, end);
      list.add(eachSchedule);
    }
  }
  return list;
}

class Schedule {
  Schedule(this.time, this.check1, this.check2, this.check3, this.check4,
      this.check5, this.check6, this.check7, this.check8);
  final String time;
  bool check1;
  bool check2;
  bool check3;
  bool check4;
  bool check5;
  bool check6;
  bool check7;
  bool check8;
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
              DataGridCell<String>(columnName: 'date', value: e.time),
              DataGridCell(columnName: 'slot1', value: e.check1),
              DataGridCell(columnName: 'slot2', value: e.check2),
              DataGridCell(columnName: 'slot3', value: e.check3),
              DataGridCell(columnName: 'slot4', value: e.check4),
              DataGridCell(columnName: 'slot5', value: e.check5),
              DataGridCell(columnName: 'slot6', value: e.check6),
              DataGridCell(columnName: 'slot7', value: e.check7),
              DataGridCell(columnName: 'slot8', value: e.check8),
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
              scheduleData[index].check1 = value!;
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
              scheduleData[index].check1 = value!;
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
              scheduleData[index].check1 = value!;
              row.getCells()[4] =
                  DataGridCell(value: value, columnName: 'slot4');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 4));
            },
          )),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[5].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check1 = value!;
              row.getCells()[5] =
                  DataGridCell(value: value, columnName: 'slot5');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 5));
            },
          )),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[6].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check1 = value!;
              row.getCells()[6] =
                  DataGridCell(value: value, columnName: 'slot6');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 6));
            },
          )),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[7].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check1 = value!;
              row.getCells()[7] =
                  DataGridCell(value: value, columnName: 'slot7');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 7));
            },
          )),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: Checkbox(
            value: row.getCells()[8].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check1 = value!;
              row.getCells()[8] =
                  DataGridCell(value: value, columnName: 'slot8');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 8));
            },
          )),
    ]);
  }
}
