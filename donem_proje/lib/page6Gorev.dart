// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:donem_proje/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String opJobid = '';
String perJobid = '';

class Page6 extends StatefulWidget {
  @override
  State<Page6> createState() => _Page6State();
}

class _Page6State extends State<Page6> {
  String selectedPeriod;
  List dataPeriod = [];
  String selectedOperation;
  List dataOperation = [];

  Future turkishTest() async {
    var response = await http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/turkish.php"),
        body: {});
    var jsonBodyTurkish = response.body;
    var jsonDataTurkish = json.decode(jsonBodyTurkish);
    print(jsonDataTurkish);
  }

  Future allPeriod() async {
    var response = await http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/gorevPeriod.php"),
        body: {
          "user_id": bilgiler[0]['user_id'],
        });
    var jsonBodyPeriod = response.body;
    var jsonDataPeriod = json.decode(jsonBodyPeriod);

    setState(() {
      dataPeriod = jsonDataPeriod;
    });
    print(jsonDataPeriod);
    return "success";
  }

  Future allOperation() async {
    var response = await http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/gorevOperation.php"),
        body: {
          "user_id": bilgiler[0]['user_id'],
        });
    var jsonBodyOperation = response.body;
    var jsonDataOperation = json.decode(jsonBodyOperation);

    setState(() {
      dataOperation = jsonDataOperation;
    });
    print(jsonDataOperation);
    return "success";
  }

  void setOpJobid() async {
    setState(() {
      opJobid = selectedOperation;
    });
  }

  void setPerJobid() async {
    setState(() {
      perJobid = selectedPeriod;
    });
  }

  @override
  void initState() {
    super.initState();
    allOperation();
    allPeriod();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "G??rev Se??im Sayfas??",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*Padding(padding: EdgeInsets.all(8.0)),*/
            /*Text("Page 6 g??rev sayfas??"),*/
            Padding(padding: EdgeInsets.all(8.0)),
            //Turkish Test
            /* ElevatedButton(
                onPressed: () {
                  turkishTest();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber[700], onPrimary: Colors.black),
                child: Wrap(
                  children: [
                    Icon(Icons.library_add_check_outlined),
                    Text(
                      ' DENEME ',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                )),*/
            Text(
              "L??tfen a??a????dan ilgili i?? t??r?? ile alakal?? g??rev se??iniz\nve ayr??nt??lar sayfas??na gidiniz. Se??im Yap??n??z k??sm??\na????lm??yorsa g??reviniz yok demektir",
              style: TextStyle(color: Colors.amber[700]),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'OPERASYON ????LER??',
                      style: TextStyle(fontSize: 17, color: Colors.amber[700]),
                    ),
                    DropdownButton(
                      value: selectedOperation,
                      hint: Text("Se??im Yap??n??z"),
                      items: dataOperation.map(
                        (list) {
                          return DropdownMenuItem(
                            child: Text(list['name']),
                            value: list['job_id'].toString(),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedOperation = value;
                          print(value);
                        });
                        setOpJobid();
                      },
                      onTap: () {},
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/page7");
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber[700],
                            onPrimary: Colors.black),
                        child: Wrap(
                          children: [
                            Icon(Icons.open_in_new_outlined),
                            Text(
                              ' Operasyon G??rev Ayr??nt??lar??na Git',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'PER??YOD??K ????LER',
                      style: TextStyle(fontSize: 17, color: Colors.amber[700]),
                    ),
                    DropdownButton(
                      value: selectedPeriod,
                      hint: Text("Se??im Yap??n??z"),
                      items: dataPeriod.map(
                        (list) {
                          return DropdownMenuItem(
                            child: Text(list['name']),
                            value: list['job_id'].toString(),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPeriod = value;
                          print("Selected value per:" + selectedPeriod);
                          print(value);
                        });
                        setPerJobid();
                        print("selected period:" + selectedPeriod);
                      },
                      onTap: () {},
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/page9");
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber[700],
                            onPrimary: Colors.black),
                        child: Wrap(
                          children: [
                            Icon(Icons.library_add_check_outlined),
                            Text(
                              ' Periyodik G??rev Ayr??nt??lar??na Git',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        )),
                    //Deneme Tusu
                    /*ElevatedButton(
                        onPressed: () {
                          print("perjobid : " +
                              perJobid +
                              "\n" +
                              "userid: " +
                              userid);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber[700],
                            onPrimary: Colors.black),
                        child: Wrap(
                          children: [
                            Icon(Icons.library_add_check_outlined),
                            Text(
                              ' DENEME',
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        )),*/
                  ],
                ),
              ),
            ),
            Expanded(
              child: Text(" "),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/LoginPage");
                      },
                      icon: Icon(Icons.login),
                      color: Colors.amber[700],
                    ),
                    Text("Login"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/page6");
                      },
                      icon: Icon(Icons.refresh),
                      color: Colors.amber[700],
                    ),
                    Text("Yenile"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _popupDialog2(context);
                      },
                      icon: Icon(Icons.account_circle_sharp),
                      color: Colors.amber[700],
                    ),
                    Text("Bilgi"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/page4");
                      },
                      icon: Icon(Icons.help),
                      color: Colors.amber[700],
                    ),
                    Text("Talep"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/page5");
                      },
                      icon: Icon(Icons.group_outlined),
                      color: Colors.amber[700],
                    ),
                    Text("Destek"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/page6");
                      },
                      icon: Icon(Icons.work),
                      color: Colors.amber[700],
                    ),
                    Text("G??rev"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (user_type_id == '1') {
                          Navigator.pushReplacementNamed(context, "/page1");
                        } else {
                          Navigator.pushReplacementNamed(context, "/page2");
                        }
                      },
                      icon: Icon(Icons.home),
                      color: Colors.amber[700],
                    ),
                    Text("Ana Sayfa"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _popupDialog2(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ButtonBarTheme(
            data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
            child: AlertDialog(
              title: Text('Kullan??c?? Bilgileri'),
              content: Text("Kullan??c?? id: " +
                  bilgiler[0]['user_id'].toString() +
                  "\n" +
                  "Kullan??c?? adi: " +
                  bilgiler[0]['name'].toString() +
                  "\n" +
                  "Kullan??c?? soyadi: " +
                  bilgiler[0]['surname'].toString() +
                  "\n" +
                  "Kullan??c?? mail: " +
                  bilgiler[0]['mail'].toString() +
                  "\n" +
                  /*"Kullan??c?? sifre: " +
                  bilgiler[0]['password'].toString() +
                  "\n" +*/
                  "Kullan??c?? tipi: $user_type" +
                  "\n" +
                  "Kullan??c?? telefonu: " +
                  bilgiler[0]['phone'].toString()),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          //Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, "/page3");
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Text('Bilgileri De??i??tir')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/page6");
                        },
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        child: Text('??PTAL')),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
