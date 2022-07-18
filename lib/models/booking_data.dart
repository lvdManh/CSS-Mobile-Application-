import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

String apiUrl = 'https://computer-services-api.herokuapp.com';

class BookingData with ChangeNotifier
{
  Map<String,dynamic> _map = {};
  bool _error = false;
  String _errorMessage = '';

  Map<String,dynamic> get map => _map;
  bool get error => _error;
  String get errorMessage => _errorMessage;

  // Get Booking data from Api url
  Future<void> get fetchData async {
    final response = await get(
      Uri.parse('$apiUrl/booking/all'),
    );

    if(response.statusCode == 200)
    {
      try
          {
            _map = jsonDecode(response.body);
            _error = false;

          }
          catch (e)
          {
            _error = true;
            _errorMessage = e.toString();
            _map = {};
          }
          notifyListeners();
    }
    else
      {
        _error = true;
        _errorMessage = 'Error: Internet connection failed!';
        _map = {};
      }
    notifyListeners();
  }

  void initialValues(){
    _map = {};
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }


}