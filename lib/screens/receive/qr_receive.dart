import 'dart:typed_data';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';
import 'package:olupay/screens/send/complete_send.dart';
// import 'package:permission_handler/permission_handler.dart';

class QrReceive extends StatefulWidget {
  String userid;
  QrReceive({super.key, required this.userid});

  @override
  State<QrReceive> createState() => _QrReceiveState();
}

class _QrReceiveState extends State<QrReceive> {
  MobileScannerController cameraController = MobileScannerController();

  bool face = false;
  changeCameraFace() {
    setState(() {
      cameraController.switchCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front, color: Colors.red);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear, color: Colors.blue);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        // fit: BoxFit.contain,
        controller: cameraController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CompleteSend(
                          data: barcode.rawValue,
                          userid: widget.userid,
                        )));
            debugPrint('Barcode found! ${barcode.rawValue}');
          }
        },
      ),
    );
  }
}
