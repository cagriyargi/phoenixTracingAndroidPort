// ignore: file_names
// ignore_for_file: file_names

import 'package:donem_proje/main.dart';
import 'package:http/http.dart' as http;

import 'desteks.dart';

var deneme = bilgiler[0]['user_id'];

Future<List<DestekSorgu>> fetchDestekler(deneme) async {
  var response = await http.post(
      Uri.parse("https://phoenixtracing.com/mobil_php/destekQuery.php"),
      body: {"user_id": bilgiler[0]['user_id']});
  print(bilgiler[0]['user_id']);
  return destekSorguFromJson(response.body);
}
