// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:donem_proje/page10GorPerSteps.dart';
import 'package:donem_proje/page11GorPerQR.dart';
import 'package:donem_proje/page1Teknis.dart';
import 'package:donem_proje/page2Nakli.dart';
import 'package:donem_proje/page4DestGon.dart';
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

class Page3 extends StatefulWidget {
  @override
  _Page3State createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  TextEditingController username = TextEditingController();
  TextEditingController usersurname = TextEditingController();
  TextEditingController usermail = TextEditingController();
  TextEditingController userpass = TextEditingController();
  TextEditingController userphone = TextEditingController();

  void updateUser() async {
    var bytes = utf8.encode(userpass.text);
    var digest = sha256.convert(bytes);
    var hexDigest = digest.toString();

    http.post(Uri.parse("https://phoenixtracing.com/mobil_php/userupdate.php"),
        body: {
          "user_id": bilgiler[0]['user_id'],
          "name": username.text,
          "surname": usersurname.text,
          "mail": usermail.text,
          "password": hexDigest,
          "phone": userphone.text,
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Kullanıcı Bilgi Değiştirme Ekranı',
          style: TextStyle(color: Colors.black),
        ),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*Padding(
              padding: EdgeInsets.all(5),
            ),*/
            /*Text(
              'PAGE 3',
              style: TextStyle(fontSize: 20),
            ),*/
            Padding(
              padding: EdgeInsets.all(2),
            ),
            Text(
              "Değiştirmek istediğiniz alanları girin:",
              style: TextStyle(fontSize: 15.0, color: Colors.amber[700]),
            ),
            /*Padding(
              padding: EdgeInsets.all(2),
            ),*/
            TextField(
              controller: username,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.account_circle_sharp,
                    color: Colors.amber[700],
                  ),
                  hintText: 'Eski Adınız: ' + bilgiler[0]['name'].toString()),
            ),
            TextField(
              controller: usersurname,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.amber[700],
                ),
                hintText:
                    'Eski Soyadınız: ' + bilgiler[0]['surname'].toString(),
              ),
            ),
            TextField(
              controller: usermail,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.mail_outline,
                    color: Colors.amber[700],
                  ),
                  hintText: 'Eski Mailiniz: $user_mail'),
            ),
            TextField(
              controller: userpass,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.vpn_key,
                  color: Colors.amber[700],
                ),
                hintText: "Yeni şifrenizi giriniz.",
              ),
            ),
            TextField(
              controller: userphone,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: Colors.amber[700],
                  ),
                  hintText:
                      'Eski Telefonunuz: ' + bilgiler[0]['phone'].toString()),
            ),
            Padding(
              padding: EdgeInsets.all(3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                ElevatedButton(
                  child: Wrap(
                    children: [
                      Icon(
                        Icons.published_with_changes,
                      ),
                      Text(
                        "BİLGİLERİ DEĞİŞTİR",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  onPressed: () {
                    updateUser();
                    Navigator.pushReplacementNamed(context, "/LoginPage");
                    //Navigator.pop(context);
                    Fluttertoast.showToast(msg: "BİLGİLER DEĞİŞTİRİLDİ");
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber[700], onPrimary: Colors.black),
                ),
                Padding(
                  padding: EdgeInsets.all(3),
                ),
                ElevatedButton(
                  child: Wrap(
                    children: [
                      Icon(
                        Icons.arrow_back_outlined,
                      ),
                      Text(
                        "İPTAL",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  onPressed: () {
                    if (user_type_id == '1') {
                      Navigator.pushReplacementNamed(context, "/page1");
                    } else {
                      Navigator.pushReplacementNamed(context, "/page2");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber[700], onPrimary: Colors.black),
                ),
              ],
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
                        Navigator.pushReplacementNamed(context, "/page3");
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
                    Text("Bilgiler"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/page5");
                      },
                      icon: Icon(Icons.help),
                      color: Colors.amber[700],
                    ),
                    Text("Talepler"),
                  ],
                ),
                Text("I"),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/page4");
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
                    Text("Görevler"),
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
                          Navigator.pushReplacementNamed(context, "/page3");
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
