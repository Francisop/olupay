import 'dart:typed_data';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';

class QrSend extends StatefulWidget {
  const QrSend({super.key});

  @override
  State<QrSend> createState() => _QrSendState();
}

class _QrSendState extends State<QrSend> {
  MobileScannerController cameraController = MobileScannerController();
  bool face = false;
  CameraFacing changeCameraFace() {
    if (face == false) {
      return CameraFacing.back;
    } else {
      return CameraFacing.front;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scan Code'),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                // height: MediaQuery.of(context).size. * 0.5,
                child: MobileScanner(
                  controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.normal,
                    facing: changeCameraFace(),
                    torchEnabled: true,
                  ),
                  fit: BoxFit.contain,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    final Uint8List? image = capture.image;
                    for (final barcode in barcodes) {
                      debugPrint('Barcode found! ${barcode.rawValue}');
                    }
                  },
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Center(
                child: Container(
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        face = true;
                      });
                    },
                    child: CircleAvatar(
                        radius: 50,
                        child: Icon(
                          Icons.cameraswitch_rounded,
                          size: 40,
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
