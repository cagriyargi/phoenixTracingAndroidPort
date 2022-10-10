// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, unnecessary_string_interpolations, avoid_print

import 'dart:convert';

import 'package:donem_proje/gorevsPer.dart';
import 'package:donem_proje/main.dart';
import 'package:donem_proje/page6Gorev.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'gorevs-api.dart';

//page6dan gelen opJobid
//page7de olan opjobid ve page8e falan da öyle aktarılıyor

String gorevid = '';
String gorevReqid9 = '';

var perjobid = '';
var perrequestid = '';
var pertechid = '';
var perjobname = '';
var perjobdetail = '';
var perjobpriority = '';
var perjobadd = '';
var perjobstart = '';
var perjobend = '';
var perjobstatus = '';
var perjobactive = '';
var perjobBilgiler = [];

class Page9 extends StatefulWidget {
  @override
  State<Page9> createState() => _Page9State();
}

class _Page9State extends State<Page9> {
  void update() {
    http.post(Uri.parse("https://phoenixtracing.com/mobil_php/update.php"),
        body: {"gorevid": gorevid, "userid": userid});
  }

  void perJobList() async {
    var response = await http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/gorevPerPage9.php"),
        body: {
          "job_id": perJobid,
          "userid": userid,
        });
    var perJobs = jsonDecode(response.body);
    setState(() {
      perjobid = perJobs[0]['job_id'];
      perrequestid = perJobs[0]['request_id'];
      pertechid = perJobs[0]['technician_id'];
      perjobname = perJobs[0]['name'];
      perjobdetail = perJobs[0]['detail'];
      perjobpriority = perJobs[0]['priority'];
      perjobadd = perJobs[0]['address_id'];
      perjobstart = perJobs[0]['start_date'];
      perjobend = perJobs[0]['end_date'];
      perjobstatus = perJobs[0]['status_id'];
      perjobactive = perJobs[0]['active'];
      perjobBilgiler = perJobs;
    });
    print(perjobBilgiler);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Periyodik Görev Listesi Sayfası",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            /*Text("Page9"),*/
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              "Periyodik görevleriniz aşağıda listelenmiştir.",
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
                        future: fetchGorevlerPer(userid, perJobid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                GorevlerPer gorevler = snapshot.data[index];
                                return InkWell(
                                    onTap: () {
                                      print("tıklandı PAGE9");
                                      gorevid = gorevler.jobId;
                                      gorevReqid9 = gorevler.requestId;
                                      perJobList();
                                      setState(() {
                                        perjobid = gorevid;
                                        perrequestid = gorevReqid9;
                                      });
                                      Navigator.pushReplacementNamed(
                                          context, "/page10");
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
                        Navigator.pushReplacementNamed(context, "/page9");
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
                          Navigator.pushReplacementNamed(context, "/page9");
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
