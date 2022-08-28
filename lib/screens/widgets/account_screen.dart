
import 'package:computer_service_system/features/auth_services.dart';
import 'package:computer_service_system/providers/data_class.dart';
import 'package:computer_service_system/screens/widgets/account_button.dart';
import 'package:computer_service_system/screens/widgets/change_password_widget.dart';
import 'package:computer_service_system/screens/widgets/update_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/color_constant.dart';
import '../../features/user_services.dart';
import '../../models/user.dart';



class AccountScreen extends StatefulWidget {
  static const String routeName = '/account-screen';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final UserServices userService = UserServices();
  Future<Account> getUser(accessToken) async{
    return userService.getUserData(accessToken);
  }
  String parseDate(time){

    DateTime dt1 = DateTime.parse(time);
    DateTime dt2 = dt1.add(const Duration(hours: 7));
    return '${dt2.day}/${dt2.month}/${dt2.year}';
  }
  String parseAddress(street, ward, district, city){
    String txt = '';
    if(street != 'Empty'){
      txt += '$street, ';
    }
    if(ward != 'Empty'){
      txt += '$ward, ';
    }
    if(district != 'Empty'){
      txt += '$district, ';
    }
    if(city != 'Empty'){
      txt += '$city';
    }
    return txt;
  }
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DataClass>(context).user;
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            "Tài khoản",
            style: TextStyle(
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: mBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        child: FutureBuilder<Account>(
          future: getUser(user.accessToken),
          builder: (context,snapshot) {
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else{
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: <
            Widget>[
            const SizedBox(height: 16),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("Tài khoản:",
                        style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                    Text(user.username,
                        style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),
                  ],
                ),
                const Divider()
              ],
            ),
            const SizedBox(height: 16),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Tên người dùng:",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(snapshot.data?.name ?? "",
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),

                    ],
                  ),
                  const Divider()
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Email:",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(snapshot.data?.email ?? "",
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),

                    ],
                  ),
                  const Divider()
                ],
              ),
              const SizedBox(height: 16),

              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Số điện thoại liên lạc:",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(snapshot.data?.phonenum ?? "",
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),

                    ],
                  ),
                  const Divider()
                ],
              ),
              const SizedBox(height: 16),

              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Ngày sinh:",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                      Text(parseDate(snapshot.data?.birth),
                          style: const TextStyle(fontSize: 18, fontFamily: 'Regular')),

                    ],
                  ),
                  const Divider()
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text("Địa chỉ:",
                          style: TextStyle(fontSize: 18, fontFamily: 'Regular')),
                        Flexible(
                          child: Text(parseAddress(snapshot.data?.address?.street,
                              snapshot.data?.address?.ward,
                              snapshot.data?.address?.district,
                              snapshot.data?.address?.city),
                            style: const TextStyle(fontSize: 18, fontFamily: 'Regular'),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,),
                        ),


                    ],
                  ),
                  const Divider()
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  AccountButton(
                    text: 'Cập nhật thông tin',
                    onTap: () =>{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateProfileScreen(account: snapshot.data!,token: user.accessToken,))),
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  AccountButton(
                    text: 'Đổi mật khẩu',
                    onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen(token: user.accessToken,))),
                          //changePass(user.accessToken),

                    },
                  ),
                ],
              ),

              const SizedBox(height: 16),
                Row(
                  children: [
                    AccountButton(
                      text: 'Đăng xuất',
                      onTap: () => AuthService().logOut(context),
                    ),
                  ],
                ),
 ],
            );
            }
          }
        ),
      ),
    );
  }
}
