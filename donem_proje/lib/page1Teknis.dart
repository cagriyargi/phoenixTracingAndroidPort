// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, unnecessary_string_interpolations, avoid_print

import 'package:donem_proje/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String gorevid = '';
double iconsize = 50;
const paddingDeger = 10.0;

class MyHomePage1 extends StatefulWidget {
  @override
  State<MyHomePage1> createState() => _MyHomePage1State();
}

class _MyHomePage1State extends State<MyHomePage1> {
  void update() {
    http.post(Uri.parse("https://phoenixtracing.com/mobil_php/update.php"),
        body: {"gorevid": gorevid, "userid": userid});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Selam $user_type $username",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'TEKNİSYEN ANA SAYFA',
              style: TextStyle(fontSize: 20, color: Colors.amber[700]),
            ),
            Padding(padding: const EdgeInsets.all(paddingDeger)),
            Expanded(
              child: ListView(
                children: [
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.login,
                        size: iconsize,
                        color: Colors.amber[700],
                      ),
                      title: Text(
                        "Login Sayfasına Dön",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          "Tekrar giriş yapmak için giriş sayfasına yönlendirir"),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/LoginPage");
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(paddingDeger)),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.refresh,
                        size: iconsize,
                        color: Colors.amber[700],
                      ),
                      title: Text("Sayfayı Yenile"),
                      subtitle: Text("Sayfayı tekrar yükler, yeniler"),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/page1");
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(paddingDeger)),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: iconsize,
                        color: Colors.amber[700],
                      ),
                      title: Text("Kullanıcı Bilgilerini Görüntüle"),
                      subtitle:
                          Text("Kullanıcının ayrıntılı bilgilerini gösterir"),
                      onTap: () {
                        _popupDialog2(context);
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(paddingDeger)),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.contact_support,
                        size: iconsize,
                        color: Colors.amber[700],
                      ),
                      title: Text("Destek Talebi Oluştur"),
                      subtitle: Text("Destek talebi oluşturur"),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/page4");
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(paddingDeger)),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.group_outlined,
                        size: iconsize,
                        color: Colors.amber[700],
                      ),
                      title: Text("Destek Talepleri Sayfasına Git"),
                      subtitle: Text(
                          "Önceden oluşturulmuş destek taleplerini görüntüler"),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/page5");
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(paddingDeger)),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.work,
                        size: iconsize,
                        color: Colors.amber[700],
                      ),
                      title: Text("Görev Sayfasına Git"),
                      subtitle: Text("Görev listesini görüntülemek için"),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/page6");
                      },
                    ),
                  ),
                ],
              ),
            ),
            //bottomBar
            /*Row(
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
                        Navigator.pushReplacementNamed(context, "/page1");
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
            ),*/
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
                          Navigator.pushReplacementNamed(context, "/page3");
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Text('Bilgileri Değiştir')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/page1");
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
