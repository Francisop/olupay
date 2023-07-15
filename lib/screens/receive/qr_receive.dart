import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrRecieve extends StatelessWidget {
  String data = "";
  QrRecieve({super.key, required this.data});

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
            child: (data != '')
                ? Container(
                    child: QrImageView(
                      data: '1234567890',
                      version: QrVersions.auto,
                      size: 300.0,
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ]),
      ),
    );
  }
}
