import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:olupay/screens/send/qr_send.dart';
import 'package:olupay/service/constants.dart';

import '../../service/firestore_service.dart';
import '../receive/bluetooth_send.dart';
import '../receive/qr_receive.dart';

class DashboardScreen extends StatefulWidget {
  var userid;
  DashboardScreen({super.key, required this.userid});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _amountController = TextEditingController();
  final _db = FirestoreService();
  var dave = {};

// getDatafromfirebase
  void process() async {
    print(widget.userid);
    await _db.getUserById(widget.userid).then((value) => {
          setState(() {
            Constants.userDetails = value.data();
            dave = value.data();
            print(value.data());
          })
        });
  }

  @override
  void initState() {
    process();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Constants.userDetails.isNotEmpty)
            ? Text(Constants.userDetails['username'])
            : Text("-----"),
      ),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  child: Text("Balance"),
                ),
                Text(
                  "N${Constants.userDetails['balance']}",
                  style: TextStyle(fontSize: 30),
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
                return const ListTile(
                  title: Text("hello"),
                  subtitle: Text("hello"),
                  leading: CircleAvatar(child: Icon(Icons.accessible)),
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

  widgetReceiveSheet() {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QrSend(
                                      data:
                                          '${Constants.userDetails['username']}-${Constants.userDetails['email']}',
                                    )));
                      },
                      child: Icon(
                        Icons.qr_code_scanner_outlined,
                        size: 70,
                      )),
                ],
              ));
        });
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
                  const Icon(
                    Icons.bluetooth,
                    size: 70,
                  ),
                  const Divider(
                    color: Colors.black,
                    thickness: 3.0,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>  QrReceive( userid: widget.userid,)));
                      },
                      child: const Icon(
                        Icons.qr_code,
                        size: 70,
                      )),
                ],
              ));
        });
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 10,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.grey,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Enter the amount',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      hintText: "Enter Amount",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.purple[100],
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => QrReceive(
                                      userid: widget.userid,
                                    )));
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                      label: Text(
                        "Continue",
                      )),
                )
                // Add more widgets as needed
              ],
            ),
          );
        });
      },
    );
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
