import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/constants/utils.dart';
import 'package:computer_service_system/features/registing_work.dart';
import 'package:computer_service_system/models/staff_register.dart';
import 'package:computer_service_system/models/work_schedule_data.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/staff_screens/staff_home_page.dart';
import 'package:computer_service_system/screens/staff_screens/view_appointment_page.dart';
import 'package:computer_service_system/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../constants/color_constant.dart';
import '../../features/schedule_services.dart';
import '../widgets/account_screen.dart';

class StaffRegistWork extends StatefulWidget {
  static const String routeName = '/staff_regist_work';
  const StaffRegistWork({Key? key}) : super(key: key);
  @override
  State<StaffRegistWork> createState() => _StaffRegistWorkState();
}

class _StaffRegistWorkState extends State<StaffRegistWork> {
  int _selectedItemIndex = 2;
  bool isChecked = false;
  late ScheduleDataSource scheduleDataSource;
  List<Slot> schedules = [];
  List<StaffRegister> list = [];
  int selectWeek = 0;
  List<WorkSchedule> futureWorkSchedule = [];
  Future<List<WorkSchedule>> getFutureWorkSchedule() async {
    futureWorkSchedule = await ScheduleServices().fetchWorkSlotList();
    return futureWorkSchedule;
  }

  List<WorkSchedule> listOpenDay = [];
  List<WorkSchedule> getListOpenDay(){
    listOpenDay.clear();
    for (var dayCompare in nextTwoWeek) {
      for(var dayInList in futureWorkSchedule){
        if(requestDate(dayInList.date).compareTo(requestDate(dayCompare))==0 ){
          listOpenDay.add(dayInList);
        }
      }
    }
    return listOpenDay;
  }
  List<String> nextTwoWeek = [];
  List<String> weekday() {
    var nextWeekDay = DateTime.now().add(Duration(days: selectWeek));
    var startFrom = nextWeekDay.subtract(Duration(days: nextWeekDay.weekday));
    nextTwoWeek =
        List.generate(7, (i) => '${startFrom.add(Duration(days: i))}');
    return nextTwoWeek;
  }
  bool isLoading = false;

  @override
  void initState() {
    weekday();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<DataClass>(context).user.accessToken;
    String userId = Provider.of<DataClass>(context).user.id;
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.5,
      color: Colors.black12.withOpacity(0.3),
      progressIndicator: const CircularProgressIndicator(),
      child: Scaffold(
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
          decoration: const BoxDecoration(color: mBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 20),
                    child: Text('Đăng ký lịch làm việc theo tuần',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.skip_previous_rounded),
                              onPressed: (){
                                setState(() {
                                  selectWeek -= 7;
                                  weekday();
                          });}),
                          Text(parseDay(nextTwoWeek.first),
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          const Text(' - ', style: TextStyle(fontSize: 24, fontFamily: 'Regular'),),
                          Text(parseDay(nextTwoWeek.last),
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'Regular')),
                          IconButton(
                              icon: const Icon(
                                  Icons.skip_next_rounded), onPressed: (){
                            setState(() {
                              selectWeek += 7;
                              weekday();
                            });
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                    future: getFutureWorkSchedule(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        getListOpenDay();
                        schedules = getScheduleData(nextTwoWeek,listOpenDay,userId);
                        scheduleDataSource = ScheduleDataSource(scheduleData: schedules, checkWeek: selectWeek);
                        return Expanded(
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
                        );
                      }
                    }),
                if(selectWeek >= 0 && selectWeek <= 28)Container(
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
                            checkAndPostSchedule(list, schedules, token, context);

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
            buildNavBarItem(Icons.schedule, 2),
            buildNavBarItem(Icons.person, 3)
          ],
        ),
        // This is Background Color
      ),
    );
  }

  checkAndPostSchedule(List<StaffRegister> list, schedule, token, context) async {
    int slotCount = checkMaxSlot(schedule);
    if(list.isEmpty){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        title: 'Chưa chọn lịch làm việc',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }else if(list.length/2 + slotCount>14){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        title: 'Đăng ký tối đa 14 slots/tuần',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          list.clear();
        },
      ).show();
    }
    else{
      List<StaffRegister> slotList = [];
      slotList.addAll(list);
      ListScheduleRegister datas = ListScheduleRegister(datas: []);
      datas.datas = slotList;
      setState(() {
        isLoading = true;
      });
      await StaffAssignWorkSchedule().addSchedule(context, token, datas);
      setState(() {
        isLoading = false;
      });
    }
  }


  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
        if(_selectedItemIndex == 1){
          Navigator.pushNamedAndRemoveUntil(
            context,
            StaffViewAppointmentPage.routeName,
                (route) => false,
          );
        }
        if(_selectedItemIndex == 0){
          Navigator.pushNamedAndRemoveUntil(
            context,
            StaffHomePage.routeName,
                (route) => false,
          );
        }
        if(_selectedItemIndex == 2){
          Navigator.pushNamedAndRemoveUntil(
            context,
            StaffRegistWork.routeName,
                (route) => false,
          );
        }
        if(_selectedItemIndex == 3){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => const AccountScreen()
          ));
        }
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
  String mon = dt1.month.toString();
  if(mon.length==1){
    mon = '0$mon';
  }
  return '${dt1.year}-$mon-${dt1.day}';
}

List<Slot> getScheduleData(List listDay,List<WorkSchedule> listOpenDay, userId) {
    List<Slot> list = [];
    for (int i = 0; i < listDay.length; i++) {
      list.add(
          Slot(
              listDay[i],
              checkSlotAvailable(listDay[i], 1,2,listOpenDay),
              checkSlotAvailable(listDay[i], 3,4,listOpenDay),
              checkSlotAvailable(listDay[i], 5,6,listOpenDay),
              checkSlotAvailable(listDay[i], 7,8,listOpenDay),
              checkSlotAvailable(listDay[i], 1,2,listOpenDay),
              checkSlotAvailable(listDay[i], 3,4,listOpenDay),
              checkSlotAvailable(listDay[i], 5,6,listOpenDay),
              checkSlotAvailable(listDay[i], 7,8,listOpenDay),
              checkSlotAssigned(listDay[i], 1,2,listOpenDay,userId),
              checkSlotAssigned(listDay[i], 3,4,listOpenDay,userId),
              checkSlotAssigned(listDay[i], 5,6,listOpenDay,userId),
              checkSlotAssigned(listDay[i], 7,8,listOpenDay,userId),
          ));
    }

    return list;
}
bool checkSlotAssigned(String day,int slotFirst,int slotLast,List<WorkSchedule> listOpenDay, userId){
  bool assigned = false;
  for(var item in listOpenDay){
    if(parseDay(day) == parseDay(item.date)){
      for(var ele in item.slots!) {
        if (slotFirst == ele.slot || slotLast == ele.slot) {
          for (var e in ele.workSlot!) {
            if (e.staffId?.id == userId) {
              assigned = true;
            }
          }
        }
      }
      }
    }

  return assigned;
}

int checkMaxSlot(List<Slot> slot){
  int count =0;
  for(var element in slot){
    if(element.isAssigned1 == true){
      count++;
    }
    if(element.isAssigned2 == true){
      count++;
    }
    if(element.isAssigned3 == true){
      count++;
    }
    if(element.isAssigned4 == true){
      count++;
    }
  }
  return count;
}

bool checkSlotAvailable(String day,int slotFirst,int slotLast,List<WorkSchedule> listOpenDay){
  bool open = false;
  for(var item in listOpenDay){
    if(parseDay(day) == parseDay(item.date)){
      if(item.slots!.length==3){
        open = true;
      }
      if(item.status !='open'){
        open = true;
      }
      for(var ele in item.slots!){
        if(slotFirst == ele.slot || slotLast == ele.slot){
          if(ele.status != 'Available'){
            open = true;
          }
          if(ele.workSlot!.length >= ele.maxPer!){
            open = true;
          }
        }
      }
    }
  }
  return open;
}

List<StaffRegister> getScheduleDataOfEachDay(List<Slot> schedule) {
  List<StaffRegister> list = [];
  for (int i = 0; i < schedule.length; i++) {
    String time = schedule[i].time;
    if (schedule[i].check1 == true && schedule[i].valid1==false && schedule[i].isAssigned1 ==false) {
      final eachSchedule1 =
          StaffRegister(date: requestDate(time), slot: 1, start: 800, end: 930);
      list.add(eachSchedule1);
      final eachSchedule2 = StaffRegister(
          date: requestDate(time), slot: 2, start: 930, end: 1100);
      list.add(eachSchedule2);
    }

    if (schedule[i].check2 == true && schedule[i].valid2==false && schedule[i].isAssigned2 ==false) {
      final eachSchedule1 = StaffRegister(
          date: requestDate(time), slot: 3, start: 1100, end: 1230);
      list.add(eachSchedule1);
      final eachSchedule2 = StaffRegister(
          date: requestDate(time), slot: 4, start: 1230, end: 1400);
      list.add(eachSchedule2);
    }

    if (schedule[i].check3 == true && schedule[i].valid3==false && schedule[i].isAssigned3 ==false) {
      final eachSchedule1 = StaffRegister(
          date: requestDate(time), slot: 5, start: 1400, end: 1530);
      list.add(eachSchedule1);
      final eachSchedule2 = StaffRegister(
          date: requestDate(time), slot: 6, start: 1530, end: 1700);
      list.add(eachSchedule2);
    }

    if (schedule[i].check4 == true && schedule[i].valid4==false && schedule[i].isAssigned4 ==false) {
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


class Slot {
  Slot(this.time,
      this.check1,  this.check2, this.check3, this.check4,
      this.valid1, this.valid2, this.valid3, this.valid4,
      this.isAssigned1, this.isAssigned2, this.isAssigned3, this.isAssigned4);
  final String time;
  bool check1;
  bool check2;
  bool check3;
  bool check4;
  bool valid1;
  bool valid2;
  bool valid3;
  bool valid4;
  bool isAssigned1;
  bool isAssigned2;
  bool isAssigned3;
  bool isAssigned4;
}

class ScheduleDataSource extends DataGridSource {
  int checkWeek;
  ScheduleDataSource({required this.scheduleData, required this.checkWeek}) {
    updateDataGridRow();
  }

  List<DataGridRow> _dataGridRow = [];
  List<Slot> scheduleData = [];
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
          child: !scheduleData[_dataGridRow.indexOf(row)].valid1
              && !scheduleData[_dataGridRow.indexOf(row)].isAssigned1
              && checkMaxSlot(scheduleData) < 14
              && checkWeek >=0
              && parseDayMonthToInt(row.getCells()[0].value) > parseDayToInt(DateTime.now().toString())
              ?  Checkbox(
            value: row.getCells()[1].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check1 = value!;
              row.getCells()[1] =
                  DataGridCell(value: value, columnName: 'slot1');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 1));
            },
          ) : scheduleData[_dataGridRow.indexOf(row)].isAssigned1
              ? const Checkbox(value: true, onChanged: null)
              : const Checkbox(value: false, onChanged: null)),
        Container(
            alignment: Alignment.center,
            // padding: EdgeInsets.symmetric(horizontal: 16),
            child: !scheduleData[_dataGridRow.indexOf(row)].valid2
                && !scheduleData[_dataGridRow.indexOf(row)].isAssigned2
                && checkMaxSlot(scheduleData)< 14
                && checkWeek >=0
                && parseDayMonthToInt(row.getCells()[0].value) > parseDayToInt(DateTime.now().toString())
                ? Checkbox(
              value: row.getCells()[2].value,
              onChanged: (value) {
                final index = _dataGridRow.indexOf(row);
                scheduleData[index].check2 = value!;
                row.getCells()[2] =
                    DataGridCell(value: value, columnName: 'slot2');
                notifyDataSourceListeners(
                    rowColumnIndex: RowColumnIndex(index, 2));
              },
            ): scheduleData[_dataGridRow.indexOf(row)].isAssigned2
                ? const Checkbox(value: true, onChanged: null)
                : const Checkbox(value: false, onChanged: null)),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: !scheduleData[_dataGridRow.indexOf(row)].valid3
              && !scheduleData[_dataGridRow.indexOf(row)].isAssigned3
              && checkMaxSlot(scheduleData) < 14
              && checkWeek >=0
              && parseDayMonthToInt(row.getCells()[0].value) > parseDayToInt(DateTime.now().toString())
              ? Checkbox(
            value: row.getCells()[3].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check3 = value!;
              row.getCells()[3] =
                  DataGridCell(value: value, columnName: 'slot3');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 3));
            },
          ): scheduleData[_dataGridRow.indexOf(row)].isAssigned3
              ? const Checkbox(value: true, onChanged: null)
              : const Checkbox(value: false, onChanged: null)),
      Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.symmetric(horizontal: 16),
          child: ! scheduleData[_dataGridRow.indexOf(row)].valid4
              && !scheduleData[_dataGridRow.indexOf(row)].isAssigned4
              && checkMaxSlot(scheduleData) < 14
              && checkWeek >=0
              && parseDayMonthToInt(row.getCells()[0].value) > parseDayToInt(DateTime.now().toString())
              ? Checkbox(
            value: row.getCells()[4].value,
            onChanged: (value) {
              final index = _dataGridRow.indexOf(row);
              scheduleData[index].check4 = value!;
              row.getCells()[4] =
                  DataGridCell(value: value, columnName: 'slot4');
              notifyDataSourceListeners(
                  rowColumnIndex: RowColumnIndex(index, 4));
            },
          ): scheduleData[_dataGridRow.indexOf(row)].isAssigned4
              ? const Checkbox(value: true, onChanged: null)
              : const Checkbox(value: false, onChanged: null)),
    ]);
  }
}

class ProgressDialogPrimary extends StatelessWidget {
  const ProgressDialogPrimary({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness == Brightness.light;
    return Scaffold(
      body: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(mBackgroundColor),
        ),
      ),
      backgroundColor: brightness ? Colors.white.withOpacity(
          0.70) : Colors.black.withOpacity(
          0.30),
    );
  }
}
