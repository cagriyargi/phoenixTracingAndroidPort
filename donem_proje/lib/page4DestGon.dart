// ignore_for_file: file_names, unnecessary_new, use_key_in_widget_constructors, annotate_overrides, prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, avoid_print

import 'dart:convert';

import 'package:donem_proje/page10GorPerSteps.dart';
import 'package:donem_proje/page11GorPerQR.dart';
import 'package:donem_proje/page1Teknis.dart';
import 'package:donem_proje/page2Nakli.dart';
import 'package:donem_proje/page3KulBilDeg.dart';
import 'package:donem_proje/page5DestLis.dart';
import 'package:donem_proje/page6Gorev.dart';
import 'package:donem_proje/page7GorOpList.dart';
import 'package:donem_proje/page8GorOpSteps.dart';
import 'package:donem_proje/page9GorPerList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Colors.amber[700]),
        brightness: Brightness.dark,
      ),
      routes: <String, WidgetBuilder>{
        '/page1': (_) => new MyHomePage1(), //teknisyen
        '/page2': (_) => new MyHomePage2(), //depocu
        '/page3': (_) => new Page3(), //kullanici bilgileri
        '/page4': (_) => new Page4(), //destek gonder
        '/page5': (_) => new Page5(), //destek talepleri
        '/page6': (_) => new Page6(), //gorev secim listesi anasayfa
        '/page7': (_) => new Page7(), //op gorev
        '/page8': (_) => new Page8(), //op gorev steps
        '/page9': (_) => new Page9(), //per gorev
        '/page10': (_) => new Page10(), //per gorev steps
        '/page11': (_) => new Page11(), //per gorev QR
        '/LoginPage': (_) => new LoginPage(),
      },
    );
  }
}

class Page4 extends StatefulWidget {
  @override
  _Page4State createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  TextEditingController name = TextEditingController();
  TextEditingController detail = TextEditingController();
  /*var datauser = [];*/

  void destek() async {
    http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/destek_insert.php"),
        body: {
          "user_id": userid,
          "destination_user_id": selectedid,
          "name": name.text,
          "detail": detail.text
        });
  }

  String selectedid;
  List data = [];

  Future getAllid() async {
    var response = await http
        .get(Uri.parse("https://phoenixtracing.com/mobil_php/destek.php"));
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });
    print(jsonData);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    getAllid();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Destek ??leti??im Ekran??',
          style: TextStyle(color: Colors.black),
        ),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /*Text(
              'Page4',
              style: TextStyle(fontSize: 15),
            ),*/
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Destek almak istedi??iniz t??r?? ve mesaj??n??z?? belirtiniz",
              style: TextStyle(fontSize: 15.0, color: Colors.amber[700]),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
              controller: name,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber[700]),
                  ),
                  icon: Icon(
                    Icons.contact_support_outlined,
                    color: Colors.amber[700],
                  ),
                  hintText: 'Destek talep ad??n?? k??saca giriniz'),
            ),
            Padding(
              padding: EdgeInsets.all(4),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              controller: detail,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber[700]),
                  ),
                  icon: Icon(
                    Icons.contact_support_rounded,
                    color: Colors.amber[700],
                  ),
                  hintText: 'Destek talep mesaj??n??z?? giriniz'),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "??lgili destek birimini se??iniz",
              style: TextStyle(fontSize: 15.0, color: Colors.amber[700]),
            ),
            Padding(
              padding: EdgeInsets.all(4),
            ),
            DropdownButton(
              value: selectedid,
              hint: Text("Se??im yap??n??z"),
              items: data.map(
                (list) {
                  return DropdownMenuItem(
                    child: Text(list['name']),
                    value: list['type_id'].toString(),
                  );
                },
              ).toList(),
              onChanged: (value) {
                setState(() {
                  selectedid = value;
                  print(value);
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(4),
            ),
            ElevatedButton(
              child: Wrap(
                children: [
                  Icon(Icons.send_to_mobile),
                  Text(
                    "DESTEK TALEB?? G??NDER",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              onPressed: () {
                destek();
                Navigator.pushReplacementNamed(context, "/page4");
                Fluttertoast.showToast(msg: "TALEB??N??Z G??NDER??LD??");
                //Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber[700], onPrimary: Colors.black),
            ),
            Expanded(
                child: Column(
              children: [Text("")],
            )),
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
                        Navigator.pushReplacementNamed(context, "/page4");
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
                          Navigator.pushReplacementNamed(context, "/page4");
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
