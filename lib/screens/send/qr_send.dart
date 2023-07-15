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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Scan Code'),
          
        ),
        body: Container(
          child: MobileScanner(
             controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.normal,
          facing: CameraFacing.front,
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

        ));
  }

}
