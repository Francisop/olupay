
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothSend extends StatefulWidget {
  const BluetoothSend({super.key});

  @override
  State<BluetoothSend> createState() => _BluetoothSendState();
}

class _BluetoothSendState extends State<BluetoothSend> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  startScan() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        if (r.device.name.isNotEmpty) {
          return;
        } else {
          print('${r.device.name} found! rssi: ${r.rssi}');
        }
      }
    });

// // Stop scanning
//     flutterBlue.stopScan();
  }

  @override
  void initState() {
    startScan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send via bluetooth')),
      body: Container(
          // child: ,
          ),
    );
  }
}
