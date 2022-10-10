// ignore_for_file: file_names

import 'package:donem_proje/gorevsPer.dart';
import 'package:donem_proje/gorevsPerSteps.dart';
import 'package:http/http.dart' as http;

import 'gorevsOp.dart';
import 'gorevsOpSteps.dart';

Future<List<GorevlerOp>> fetchGorevlerOp(userid, opjobid) async {
  var response = await http.post(
      Uri.parse("https://phoenixtracing.com/mobil_php/gorevOpAll.php"),
      body: {"userid": userid, "job_id": opjobid});
  print("opgoreviciApiAllopuid+opjobid:" + userid + opjobid);
  return gorevlerOpFromJson(response.body);
}

Future<List<GorevlerOpSteps>> fetchGorevlerOpSteps(opjobid) async {
  var response = await http.post(
      Uri.parse("https://phoenixtracing.com/mobil_php/gorevOpSteps.php"),
      body: {"job_id": opjobid});
  print("opstepiciApiOpStepsid:" + opjobid);
  return gorevlerOpStepsFromJson(response.body);
}

Future<List<GorevlerPer>> fetchGorevlerPer(userid, perjobid) async {
  var response = await http.post(
      Uri.parse("https://phoenixtracing.com/mobil_php/gorevPerAll.php"),
      body: {"userid": userid, "job_id": perjobid});
  print("pergoreviciApiGorevlerPeruid+perjobid:" + userid + perjobid);
  return gorevlerPerFromJson(response.body);
}

Future<List<GorevlerPerSteps>> fetchGorevlerPerSteps(perJobid) async {
  var response = await http.post(
      Uri.parse("https://phoenixtracing.com/mobil_php/gorevPerSteps.php"),
      body: {"request_id": perJobid});
  print("perstepiciApiPerStepsperjobid:" + perJobid);
  return gorevlerPerStepsFromJson(response.body);
}
