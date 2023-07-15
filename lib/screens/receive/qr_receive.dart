import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrRecieve extends StatefulWidget {
  const QrRecieve({super.key});

  @override
  State<QrRecieve> createState() => _QrRecieveState();
}

class _QrRecieveState extends State<QrRecieve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qrcode"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(children: [
          Center(
            child: QrImageView(
              data: '1234567890',
              version: QrVersions.auto,
              size: 300.0,
            ),
          )
        ]),
      ),
    );
  }
}
