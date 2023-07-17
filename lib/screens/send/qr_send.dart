import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrSend extends StatelessWidget {
  String data = "";
  QrSend({super.key, required this.data});

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
                      data: data,
                      version: QrVersions.auto,
                      size: 300.0,
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          Text('Scan code to transfer to ${data.split('-').first.toUpperCase()}')
        ]),
      ),
    );
  }
}
