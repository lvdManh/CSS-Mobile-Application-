
import 'package:computer_service_system/constants/color_constant.dart';
import 'package:computer_service_system/screens/customer_screens/create_booking_first_stage.dart';
import 'package:computer_service_system/screens/customer_screens/product_screen.dart';
import 'package:computer_service_system/screens/customer_screens/services_screen.dart';
import 'package:computer_service_system/screens/customer_screens/tracking_appointment.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: mBackgroundColor,
          ),
          child: ListView(
            children: [
              Stack(children: [Image.asset('assets/images/title_logo.jpg',)]),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Danh mục', style: TextStyle(
                      fontSize: 20, color: Colors.black,
                    ),
                    ),
                    Padding(padding: const EdgeInsets.only(
                        top: 20,
                    ),
                      child: SizedBox(
                        height: 300,
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 8,
                            childAspectRatio: 1.50,
                            children: [
                              _selectedAppointment(
                                image: 'assets/icons/repair.png',
                                name: 'Đặt lịch',
                                destination: 0,
                              ),
                              _selectedAppointment(
                                  image: 'assets/icons/schedule.png',
                                  name: 'Lịch hẹn',
                                destination: 1,
                              ),
                              _selectedAppointment(
                                  image: 'assets/icons/R.png',
                                  name: 'Linh kiện',
                                destination: 2,
                              ),
                              _selectedAppointment(
                                  image: 'assets/icons/store.png',
                                  name: 'Dịch vụ',
                                destination: 3,
                              ),
                            ],
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
      // Bottom Navigation
      // This is Background Color

    );
  }
  // }

  Widget _selectedAppointment({
    required String image,
    required String name,
    required int destination,
  }
    ){
    return GestureDetector(
      onTap:(){
        if( destination == 0){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => const BookAppointment()
          )
          );
        }
        if( destination == 1){
           Navigator.push(
                context, MaterialPageRoute(
               builder: (context) => const TrackingAppointment()
           )
           );

        }
        if( destination == 2){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => const ProductScreen()
          )
          );

        }
        if( destination == 3){
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => const ServicesScreen()
          )
          );
        }
      },

    child: Container(

      decoration: BoxDecoration(
        color: mFillColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: mSubtitleColor, width: 2)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(image))
              ),
          ),
          const SizedBox(height: 10,),
          Text(name, style: const TextStyle(fontSize: 17),)
        ],
      ),
    ),
    );
  }
}
