// ignore_for_file: file_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:donem_proje/page10GorPerSteps.dart';
import 'package:donem_proje/page6Gorev.dart';
import 'package:donem_proje/page9GorPerList.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

// ignore: unused_import
import 'gorevs-api.dart';
import 'page10GorPerSteps.dart';

class Page11 extends StatefulWidget {
  const Page11({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Page11State();
}

class _Page11State extends State<Page11> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrData = "";
  var requestId = perJobid;
  var stepLine = stepline;
  var qrstep_id = "";
  var qrstep_code = "";
  var qrjob_id = "";
  var qrstep_line = "";
  var qrstep = "";
  var qrdone = "";
  //var step = "";

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  void qrPost() {
    http.post(Uri.parse("https://phoenixtracing.com/mobil_php/qrScanner.php"),
        body: {"step_code": qrData, "job_id": perjobid, "step_line": stepLine});
  }

  void _popupDialog3(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ButtonBarTheme(
            data: ButtonBarThemeData(alignment: MainAxisAlignment.center),
            child: AlertDialog(
              title: Text('HATA'),
              content: Text("HATALI QR KOD"),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style:
                            ElevatedButton.styleFrom(primary: Colors.redAccent),
                        child: Text('OK')),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void qrKontrol() async {
    var response = await http.post(
        Uri.parse("https://phoenixtracing.com/mobil_php/qrScanKontrol.php"),
        body: {"step_code": qrData, "job_id": perJobid, "step_line": stepLine});
    var dataqr = jsonDecode(response.body);
    if (dataqr.length == 0) {
      print("if bloğuna giriyor");
      setState(() {
        qrData = "HATALI QR KODU";
      });
      Fluttertoast.showToast(msg: "HATALI QR KODU");
      _popupDialog3(context);
    } else {
      setState(() {
        qrstep_id = dataqr[0]['step_id'];
        qrstep_code = dataqr[0]['step_code'];
        qrjob_id = dataqr[0]['job_id'];
        qrstep_line = dataqr[0]['step_line'];
        qrstep = dataqr[0]['step'];
        qrdone = dataqr[0]['done'];
      });
    }
  }

  void perJobStepKontrol() async {
    var response = await http.post(
        Uri.parse(
            "https://phoenixtracing.com/mobil_php/gorevPerStepKontrol.php"),
        body: {"job_id": perjobid});
    var perStepKontroldata = jsonDecode(response.body);
    // ignore: avoid_print
    print("perstepkontroldata:" + perStepKontroldata.toString());
    if (perStepKontroldata.length == 0) {
      http.post(
          Uri.parse("https://phoenixtracing.com/mobil_php/gorevPerDone.php"),
          body: {"job_id": perjobid, "request_id": perrequestid});
    }
    //print("page11 jobid:" + perjobid + "---" + "requestid: " + gorevReqid9);
    //Fluttertoast.showToast(msg: "GÖREV TAMAMLANDI");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text('Kod Türü: ${describeEnum(result.format)}')
                  //Data: ${result.code}
                  else
                    const Text('Bir Kod Okutun'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //flash
                      /* Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),*/
                      //kamera dondur
                      /* Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )*/
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //pause kamera
                      /* Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),*/
                      //resume kamera
                      /*Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),*/
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber[700],
                              onPrimary: Colors.black),
                          onPressed: () async {
                            //perJobStepKontrol();
                            setState(() {
                              qrData = result.code;
                            });
                            qrKontrol();
                            //qrPost();
                            print(
                                "görevi tamamla tusunu basildi,qrdata, stepline,jobid  " +
                                    qrData +
                                    " " +
                                    stepLine +
                                    " " +
                                    perJobid);
                            //controller.pauseCamera();
                            //controller.pauseCamera();
                          },
                          // ignore: prefer_const_constructors
                          child: Text(
                            "QR OKUT",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber[700],
                              onPrimary: Colors.black),
                          onPressed: () {
                            perJobStepKontrol();
                            qrPost();
                            Navigator.pushReplacementNamed(context, "/page10");
                            //perJobStepKontrol();
                            //perJobStepKontrol();
                            //perJobStepKontrol();
                            controller.pauseCamera();
                            controller.pauseCamera();
                          },
                          // ignore: prefer_const_constructors
                          child: Text(
                            "GÖREVİ BİTİR",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber[700],
                              onPrimary: Colors.black),
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, "/page10");
                            controller.pauseCamera();
                            controller.pauseCamera();
                          },
                          child: Text(
                            "İPTAL",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.amber[700],
                              onPrimary: Colors.black),
                          onPressed: () {
                            print("stepline:" +
                                stepLine +
                                "\n" +
                                "jobid:" +
                                perJobid +
                                "\n" +
                                "prereqid: " +
                                perrequestid);
                          },
                          child: Text(
                            "DENEME",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
