// ignore_for_file: unnecessary_new, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:donem_proje/page10GorPerSteps.dart';
import 'package:donem_proje/page11GorPerQR.dart';
import 'package:donem_proje/page1Teknis.dart';
import 'package:donem_proje/page2Nakli.dart';
import 'package:donem_proje/page3KulBilDeg.dart';
import 'package:donem_proje/page4DestGon.dart';
import 'package:donem_proje/page5DestLis.dart';
import 'package:donem_proje/page6Gorev.dart';
import 'package:donem_proje/page7GorOpList.dart';
import 'package:donem_proje/page8GorOpSteps.dart';
import 'package:donem_proje/page9GorPerList.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:splash_screen_view/SplashScreenView.dart';

void main() {
  runApp(LoginApp());
}

var userid = '';
var bilgiler = [];
// ignore: non_constant_identifier_names
var user_type_id = '';
var username = '';
var usersurname = '';
var userphone = '';
var useractive = '';
// ignore: non_constant_identifier_names
var user_type = '';
// ignore: non_constant_identifier_names
var user_mail = '';
var userpassword = '';
var userpassword2 = '';

class LoginApp extends StatefulWidget {
  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // ignore: deprecated_member_use
          accentColor: Colors.amber[700],
          appBarTheme: AppBarTheme(color: Colors.amber[700]),
          brightness: Brightness.dark,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.amber[700],
            selectionHandleColor: Colors.amber[700],
            selectionColor: Colors.amber[700],
          ),
          highlightColor: Colors.amber[700]),
      home: SplashScreenView(
        navigateRoute: LoginPage(),
        duration: 5000,
        imageSize: 130,
        imageSrc: "assets/images/logo403.png",
        text: "PHOENIX TRACING",
        textType: TextType.ColorizeAnimationText,
        textStyle: TextStyle(
          fontSize: 40.0,
        ),
        colors: [
          Colors.redAccent,
          Colors.amber[700],
          Colors.deepOrange,
          Colors.yellow,
          Colors.red,
          Colors.amber,
          Colors.red[900],
        ],
        backgroundColor: Colors.grey[850],
      ),
      routes: <String, WidgetBuilder>{
        '/page1': (_) => new MyHomePage1(), //teknisyen
        '/page2': (_) => new MyHomePage2(), //tedarikçi
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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  void login() async {
    // şifre hashleme
    var bytes = utf8.encode(pass.text);
    var digest = sha256.convert(bytes);
    var hexDigest = digest.toString();

    var response = await http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/login.php"),
        body: {
          "mail": mail.text,
          "password": hexDigest,
        });
    var datauser = jsonDecode(response.body);
    if (datauser.length == 0) {
      print("Else içine giriyor");
      Fluttertoast.showToast(msg: "HATALI GİRİŞ");
    } else if (datauser[0]['user_type_id'] == '1') {
      setState(() {
        userid = datauser[0]['user_id'];
        user_mail = datauser[0]['mail'];
        user_type_id = datauser[0]['user_type_id'];
        user_type = "Teknisyen";
        username = datauser[0]['name'];
        usersurname = datauser[0]['surname'];
        userphone = datauser[0]['phone'];
        useractive = datauser[0]['active'];
        userpassword = datauser[0]['password'];
        userpassword2 = pass.text;
        bilgiler = datauser;
      });
      Fluttertoast.showToast(msg: "TEKNİSYEN GİRİŞ BAŞARILI");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage1(),
        ),
      );
    } else if (datauser[0]['user_type_id'] == '2') {
      setState(() {
        userid = datauser[0]['user_id'];
        user_mail = datauser[0]['mail'];
        user_type_id = datauser[0]['user_type_id'];
        user_type = "Tedarikçi";
        username = datauser[0]['name'];
        usersurname = datauser[0]['surname'];
        userphone = datauser[0]['phone'];
        useractive = datauser[0]['active'];
        userpassword = datauser[0]['password'];
        bilgiler = datauser;
      });
      Fluttertoast.showToast(msg: "TEDARİKÇİ GİRİŞ BAŞARILI");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage2(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'PHOENIX KULLANICI GİRİŞ EKRANI',
        ),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
            ),
            Image.asset(
              'assets/images/logo403.png',
              height: 100,
              width: 100,
            ),
            Padding(
              padding: EdgeInsets.all(7),
            ),
            Text(
              "GÖREVLERİNİZE ERİŞEBİLMEK İÇİN",
              style: TextStyle(fontSize: 15.0, color: Colors.white60),
            ),
            Text(
              "LÜTFEN SİSTEME GİRİŞ YAPINIZ.",
              style: TextStyle(fontSize: 15.0, color: Colors.white60),
            ),
            Padding(
              padding: EdgeInsets.all(7),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: mail,
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[600]),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber[700]),
                  ),
                  icon: Icon(
                    Icons.account_circle,
                  ),
                  hintText: 'Kullanıcı Adınızı Giriniz'),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber[700]),
                ),
                icon: Icon(Icons.vpn_key),
                hintText: 'Şifrenizi Giriniz',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            ElevatedButton(
              child: Wrap(
                children: [
                  Icon(Icons.login),
                  Text(
                    "GİRİŞ",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              onPressed: () {
                login();
                //Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber[700], onPrimary: Colors.black),
            ),
            //sha Test
            /*ElevatedButton(
              child: Wrap(
                children: [
                  Icon(Icons.login),
                  Text(
                    "SHA TEST",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
              onPressed: () {
                var pass = "1111";
                var bytes1 = utf8.encode(pass.toString()); // data being hashed
                var digest1 = sha256.convert(bytes1); // Hashing Process
                print("Digest as bytes: ${digest1.bytes}"); // Print Bytes
                print("Digest as hex string: $digest1");
                print("");
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber[700], onPrimary: Colors.black),
            ),*/
          ],
        ),
      ),
    );
  }
}
