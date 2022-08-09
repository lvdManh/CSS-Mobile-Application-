
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/pick_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constant.dart';
import '../../features/address_services.dart';
import '../../features/booking_services.dart';
import '../../features/service_services.dart';
import '../../models/booking_object.dart';
import '../../models/hcm_address_data.dart';
import '../../models/services_data.dart';
import 'custom_button.dart';
import 'multi_select_widget.dart';

class EditAppointment extends StatefulWidget {
  final Booking bookings;

  const EditAppointment({Key? key,required this.bookings}) : super(key: key);

  @override
  State<EditAppointment> createState() => _EditAppointmentState();
}

class _EditAppointmentState extends State<EditAppointment> {
  final _submitKey = GlobalKey<FormState>();
  final BookingServices bookingServices = BookingServices();
  final TextEditingController username = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController district = TextEditingController();
  final TextEditingController ward = TextEditingController();
  final TextEditingController street = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController description = TextEditingController();
  late List<Service> futureService;
  late List<String> serviceName = [];
  List<String> _selectedItems = [];
  late List<Address> address;
  late List<String> districts =[];
  late List<String> wards =[];
  late String selectedDistrict;
  late String selectedWard;
  late String token;
  Future<void> getNameService(token) async {
    futureService = await ServiceServices().fetchServices(token);
    for(int i =0; i < futureService.length;i++){
      serviceName.add(futureService[i].name.toString());
    }
    address = await fetchHCMAddress();
    for(int i =0; i< address.length;i++){
      districts.add(address[i].name.toString());
    }
  }
  void getWardsData() async{
    for(int i =0; i< address.length;i++){
      if(address[i].name==selectedDistrict){
        for (var element in address[i].wards) {wards.add(element.name); }
      }
    }
  }

//  late Address? selectedWard;
  void _showDistrictSelected() async {
    final String results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return PickAddress(items: districts, title: "Chọn quận",);
      },
    );
    if (results != '') {
      setState(() {
        wards.clear();
        selectedWard ='';
        selectedDistrict = results;
        getWardsData();
      });
    }
  }

  void _showWardSelected() async {
    if(wards.isNotEmpty) {
      final String results = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PickAddress(items: wards, title: "Chọn phường/khu vực",);
        },
      );
      if (results != '') {
        setState(() {
          selectedWard = results;
        });
      }
    }
  }
  void _showMultiSelect() async {
    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: serviceName, title: "dịch vụ",);
      },
    );

    if (results != null) {
      setState(() {
        _selectedItems = results;
      });
    }
  }
 bool checkFieldEmpty(){
    if(username.text.isEmpty
        || phone.text.isEmpty
        || street.text.isEmpty
        || ward.text.isEmpty
        || district.text.isEmpty
        || type.text.isEmpty
        || _selectedItems.isEmpty
        || description.text.isEmpty){
      return false;
    }
    return true;
 }

  @override
  void initState() {
    final userProvider = Provider.of<DataClass>(context, listen: false).user;
    super.initState();
    username.text = widget.bookings.cusName!;
    phone.text = widget.bookings.phonenum!;
    street.text = widget.bookings.cusAddress!.street!;
    ward.text = widget.bookings.cusAddress!.ward!;
    district.text = widget.bookings.cusAddress!.district!;
    type.text = widget.bookings.type!;
    _selectedItems.addAll(widget.bookings.services!.toList());
    description.text = widget.bookings.description!;
    selectedDistrict = widget.bookings.cusAddress!.district!;
    selectedWard =  widget.bookings.cusAddress!.ward!;
    getNameService(userProvider.accessToken);
  }

  @override
  Widget build(BuildContext context) {
    token = Provider.of<DataClass>(context,listen: false).user.accessToken;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Cập nhật lịch hẹn",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: mBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _submitKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Tên người hẹn:'),
                          controller: username,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Số điện thoại:'),
                          controller: phone,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Quận:",
                                style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6), fontFamily: 'Regular')),
                            ElevatedButton(
                              onPressed: _showDistrictSelected,
                              child: const Text('Chọn quận', style: TextStyle(fontSize: 12),),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(selectedDistrict, style: const TextStyle(fontSize: 16, fontFamily: 'Regular',),),
                          ],
                        ),

                        Divider(thickness: 1,color: Colors.black.withOpacity(0.5),),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Phường/khu vực:",
                                style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.6), fontFamily: 'Regular')),
                            ElevatedButton(
                              onPressed: _showWardSelected,
                              child: const Text('Chọn phường/khu vực', style: TextStyle(fontSize: 12),),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(selectedWard, style: const TextStyle(fontSize: 16, fontFamily: 'Regular',),),
                          ],
                        ),
                        Divider(thickness: 1,color: Colors.black.withOpacity(0.5),),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Số nhà:'),
                          controller: street,
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text("Dịch vụ:",
                                    style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: _showMultiSelect,
                                      child: const Text('Chọn dịch vụ'),
                                    ),
                                  ],
                                ),
                                // display selected items
                              ],
                            ),
                            Column(

                              children: [
                                Wrap(
                                  children: _selectedItems
                                      .map((e) => Chip(
                                    label: Text(e),
                                  ))
                                      .toList(),
                                ),
                              ],
                            ),
                            Divider(thickness: 1,color: Colors.black.withOpacity(0.5),),
                          ],
                        ),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Loại máy:'),
                          controller: type,
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration:
                          const InputDecoration(labelText: 'Mô tả vấn đề:'),
                          controller: description,
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          text: 'Cập nhật',
                          onTap: ()  {
                            if (_submitKey.currentState!.validate() && checkFieldEmpty()) {
                               AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.QUESTION,
                                dismissOnTouchOutside: false,
                                title: 'Lưu thay đổi?',
                                btnCancelOnPress: (){},
                                btnOkOnPress: () {
                                  bookingServices.editBooking(
                                      context,
                                      token,
                                      widget.bookings.id,
                                      street.text,
                                      ward.text,
                                      district.text,
                                      username.text,
                                      phone.text,
                                      _selectedItems,
                                      description.text,
                                      type.text);
                                },
                              ).show();

                            }else{
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.WARNING,
                                dismissOnTouchOutside: false,
                                title: 'Thông tin trống',
                                desc: 'Vui lòng nhập đủ thông tin',
                                btnOkOnPress: () {
                                },
                              ).show();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
