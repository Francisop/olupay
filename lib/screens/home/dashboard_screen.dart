import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:olupay/screens/receive/qr_receive.dart';

import '../send/bluetooth_send.dart';
import '../send/qr_send.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Text("N2000"),
                Container(
                  child: Text("Balance"),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          widgetSendSheet();
                        },
                        child: ActionTile(
                          icon: Icons.telegram,
                          title: "send",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widgetReceiveSheet();
                        },
                        child: ActionTile(
                          icon: Icons.download,
                          title: "recieve",
                        ),
                      ),
                      // ActionTile(icon: Icons.telegram,title: "s"),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: ((context, index) {
                return ListTile(
                  title: Text("hello"),
                  subtitle: Text("hello"),
                  leading: CircleAvatar(child: Icon(Icons.abc)),
                  trailing: Text("#2000"),
                );
              }),
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          )
        ],
      ),
    );
  }

  widgetSendSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => BluetoothSend()));
                    },
                    child: Icon(
                      Icons.bluetooth_connected_sharp,
                      size: 70,
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 3.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => QrSend()));
                      },
                      child: Icon(
                        Icons.qr_code_scanner_outlined,
                        size: 70,
                      )),
                ],
              ));
        });
  }

  widgetReceiveSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Container(
              height: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.bluetooth,
                    size: 70,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 3.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => QrRecieve()));
                      },
                      child: Icon(
                        Icons.qr_code,
                        size: 70,
                      )),
                ],
              ));
        });
  }
}

class ActionTile extends StatelessWidget {
  IconData icon;
  String title;

  ActionTile({Key? key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.purple[100],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 65,
          ),
          Text(title)
        ],
      ),
    );
  }
}
