// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, unnecessary_string_interpolations

import 'dart:convert';

import 'package:donem_proje/gorevsPerSteps.dart';
import 'package:donem_proje/page6Gorev.dart';
import 'package:donem_proje/page9GorPerList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'gorevs-api.dart';
import 'main.dart';

var stepline = '';

class Page10 extends StatefulWidget {
  @override
  State<Page10> createState() => _Page10State();
}

class _Page10State extends State<Page10> {
  @override
  void initState() {
    //showAlert(context);
    perJobBreakKontrol();
    super.initState();
  }

  bool status = true;
  bool status2 = false;

  disableButton() {
    setState(() {
      status = false;
    });
  }

  enableButton() {
    setState(() {
      status = true;
    });
  }

  void updateStep() {
    http.post(
        Uri.parse(
            "https://phoenixtracing.com/mobil_php/gorevPerStepUpdate.php"),
        body: {"job_id": perJobid, "step_line": stepline});
  }

  void perJobBreakStart() async {
    http.post(
        Uri.parse(
            "https://phoenixtracing.com/mobil_php/gorevPerBreakStart.php"),
        body: {"job_id": perJobid});
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  void perJobBreakEnd() async {
    http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/gorevPerBreakEnd.php"),
        body: {"job_id": perJobid});
    await Future.delayed(const Duration(seconds: 1), () {});
  }

  void perJobBreakKontrol() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    var response = await http.post(
        Uri.parse(
            "https://phoenixtracing.com/mobil_php/gorevPerBreakKontrol.php"),
        body: {"job_id": perJobid});
    var perBreakKontroldata = jsonDecode(response.body);
    // ignore: avoid_print
    print(perBreakKontroldata);
    if (perBreakKontroldata.length != 0) {
      //molabitir aktif
      setState(() {
        status2 = !status2;
        status = !status;
      });
    }
  }

  void perJobStepKontrol() async {
    var response = await http.post(
        Uri.parse(
            "https://phoenixtracing.com/mobil_php/gorevPerStepKontrol.php"),
        body: {"job_id": perJobid});
    var perStepKontroldata = jsonDecode(response.body);
    // ignore: avoid_print
    print(perStepKontroldata);
    if (perStepKontroldata.length == 0) {
      http.post(
          Uri.parse("https://phoenixtracing.com/mobil_php/gorevPerDone.php"),
          body: {"job_id": perJobid, "request_id": perrequestid});
      Fluttertoast.showToast(msg: "KONTROL BAŞARILI");
    } else {
      Fluttertoast.showToast(msg: "ADIMLARINIZ EKSİK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Seçilen Görevin Adımları Sayfası",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*Text("Page10"),*/
            //Deneme Tuşu
            /* ElevatedButton(
                onPressed: () {
                  print("Deneme tuşu page10 basıldı");
                  print("j büyük basıldı");
                  print(perJobid);
                  print("j büyük basıldı");
                  print(perjobid);
                  print("PAGE10 requestid:" + perrequestid);
                },
                child: Text("Deneme")),*/
            Padding(padding: EdgeInsets.all(3.0)),
            Text(
              "Seçtiğiniz görevin adımları aşağıda listelenmiştir.",
              style: TextStyle(color: Colors.amber[700]),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "İstediğiniz zaman MOLA VER tuşu ile mola verebilirsiniz.",
              style: TextStyle(color: Colors.amber[700]),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Molanızı MOLA BİTİR tuşu ile sonlandırabilirsiniz.",
              style: TextStyle(color: Colors.amber[700]),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Row(
              children: [
                ElevatedButton(
                    //status == false ? null : disableButton,
                    onPressed: status == true
                        ? () {
                            perJobBreakStart();
                            // ignore: avoid_print
                            print(perJobid);
                            // ignore: avoid_print
                            print("page10jobid yazdırılacak");
                            Navigator.pushReplacementNamed(context, "/page10");
                            Navigator.pushReplacementNamed(context, "/page10");
                          }
                        : disableButton(),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber[700], onPrimary: Colors.black),
                    child: Wrap(
                      children: [
                        Icon(Icons.free_breakfast),
                        Text(
                          'MOLA VER',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
                Padding(padding: EdgeInsets.all(25.0)),
                ElevatedButton(
                    //status ? null : enableButton,
                    onPressed: status2 == true
                        ? () {
                            perJobBreakEnd();
                            Navigator.pushReplacementNamed(context, "/page10");
                            Navigator.pushReplacementNamed(context, "/page10");
                          }
                        : enableButton(),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber[700], onPrimary: Colors.black),
                    child: Wrap(
                      children: [
                        Icon(Icons.free_breakfast_outlined),
                        Text(
                          'MOLA BİTİR',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber[700], onPrimary: Colors.black),
                onPressed: () {
                  perJobStepKontrol();
                  Navigator.pushReplacementNamed(context, "/page10");
                },
                child: Wrap(
                  children: [
                    Icon(Icons.touch_app),
                    Text(
                      "SON ADIM KONTROL",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
            Container(
              child: Expanded(
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(padding: EdgeInsets.all(3.0)),
                    Container(
                      child: FutureBuilder(
                        future: fetchGorevlerPerSteps(perJobid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                GorevlerPerSteps gorevler =
                                    snapshot.data[index];
                                return InkWell(
                                  onTap: () {
                                    // ignore: avoid_print
                                    print("tıklandı");
                                    setState(() {
                                      stepline = gorevler.stepLine;
                                    });
                                    //_popupDialog(context);
                                    Navigator.pushReplacementNamed(
                                        context, "/page11");
                                  },
                                  child: Builder(builder: (context) {
                                    return Card(child: (() {
                                      if (gorevler.done == '0') {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0)),
                                                Text(
                                                  "    Görev Adım No:",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.amber[700]),
                                                ),
                                                Text(
                                                    "          -${gorevler.stepLine}"),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0))
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0)),
                                                Text(
                                                  "    Görev Adım Adı:",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.amber[700]),
                                                ),
                                                Text(
                                                    "          -${gorevler.step}"),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0))
                                              ],
                                            ),
                                          ],
                                        );
                                      } else
                                        return Text(
                                          "    Görev Adımınız ${gorevler.step} Bitmiştir",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.amber[700]),
                                        );
                                    })());
                                  }),
                                );
                              },
                            );
                          }
                          return SizedBox(
                            height: 16,
                            width: 16,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                        //perJobStepKontrol();
                        Navigator.pushReplacementNamed(context, "/page10");
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
                    Text("Görev"),
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
              title: Text('Kullanıcı Bilgileri'),
              content: Text("Kullanıcı id: " +
                  bilgiler[0]['user_id'].toString() +
                  "\n" +
                  "Kullanıcı adi: " +
                  bilgiler[0]['name'].toString() +
                  "\n" +
                  "Kullanıcı soyadi: " +
                  bilgiler[0]['surname'].toString() +
                  "\n" +
                  "Kullanıcı mail: " +
                  bilgiler[0]['mail'].toString() +
                  "\n" +
                  /*"Kullanıcı sifre: " +
                  bilgiler[0]['password'].toString() +
                  "\n" +*/
                  "Kullanıcı tipi: $user_type" +
                  "\n" +
                  "Kullanıcı telefonu: " +
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
                        child: Text('Bilgileri Değiştir')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/page10");
                        },
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        child: Text('İPTAL')),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
