import 'dart:convert';

import 'package:computer_service_system/models/hcm_address_data.dart';
import 'package:flutter/services.dart';

Future<List<Address>> fetchHCMAddress() async {
  final response = await rootBundle.loadString('assets/HoChiMinhCityDistricts.json');
  final parsed = json.decode(response).cast<Map<String, dynamic>>();
  return  parsed.map<Address>((json) => Address.fromJson(json)).toList();
}