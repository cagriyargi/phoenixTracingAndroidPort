// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:donem_proje/main.dart';
import 'package:donem_proje/page6Gorev.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'gorevs-api.dart';
import 'gorevsOp.dart';

//page6dan gelen opJobid
//page7de olan opjobid ve page8e falan da öyle aktarılıyor
String gorevid = '';
String gorevReqid = '';

var opjobid = '';
var oprequestid = '';
var optechid = '';
var opjobname = '';
var opjobdetail = '';
var opjobpriority = '';
var opjobadd = '';
var opjobstart = '';
var opjobend = '';
var opjobstatus = '';
var opjobactive = '';
var opjobBilgiler = [];

class Page7 extends StatefulWidget {
  @override
  State<Page7> createState() => _Page7State();
}

class _Page7State extends State<Page7> {
  void opJobList() async {
    var response = await http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/gorevOpPage7.php"),
        body: {
          "job_id": opjobid,
          "userid": userid,
        });
    var opJobs = jsonDecode(response.body);
    setState(() {
      opjobid = opJobs[0]['job_id'];
      oprequestid = opJobs[0]['request_id'];
      optechid = opJobs[0]['technician_id'];
      opjobname = opJobs[0]['name'];
      opjobdetail = opJobs[0]['detail'];
      opjobpriority = opJobs[0]['priority'];
      opjobadd = opJobs[0]['address_id'];
      opjobstart = opJobs[0]['start_date'];
      opjobend = opJobs[0]['end_date'];
      opjobstatus = opJobs[0]['status_id'];
      opjobactive = opJobs[0]['active'];
      opjobBilgiler = opJobs;
    });
    print("opjobbilgiler yazdiirildi");
    print(opjobBilgiler);
    print("PAGE7 reqid: " + oprequestid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Operasyon Görev Listesi Sayfası",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*Text("Page7"),*/
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Operasyon görevleriniz aşağıda listelenmiştir.",
              style: TextStyle(color: Colors.amber[700]),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Görev adımları için ilgili bölümün üzerine tıklayın.",
              style: TextStyle(color: Colors.amber[700]),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Container(
              child: Expanded(
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Padding(padding: EdgeInsets.all(3.0)),
                    Container(
                      child: FutureBuilder(
                        future: fetchGorevlerOp(userid, opJobid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                GorevlerOp gorevler = snapshot.data[index];
                                return InkWell(
                                    onTap: () {
                                      print("tıklandı, PAGE7");
                                      gorevid = gorevler.jobId;
                                      gorevReqid = gorevler.requestId;
                                      print("PAGE7 jobid: " + gorevid);
                                      print("PAGE7 reqid: " + gorevReqid);
                                      opJobList();
                                      setState(() {
                                        opjobid = gorevid;
                                        oprequestid = gorevReqid;
                                      });
                                      Navigator.pushReplacementNamed(
                                          context, "/page8");
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
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
                                                  "Görev Adı:",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.amber[700]),
                                                ),
                                                Text("      -${gorevler.name}"),
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
                                                  "Görev Ayrıntıları:",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.amber[700]),
                                                ),
                                                Text(
                                                    "      -${gorevler.detail}"),
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
                                                  "Görev Adresi:",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.amber[700]),
                                                ),
                                                Text(
                                                    "      -${gorevler.addressId}"),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.all(3.0))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
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
                        Navigator.pushReplacementNamed(context, "/page7");
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
                          Navigator.pushReplacementNamed(context, "/page7");
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
