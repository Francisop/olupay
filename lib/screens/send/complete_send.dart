import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../service/constants.dart';
import 'package:pinput/pinput.dart';

import '../../service/firestore_service.dart';

class CompleteSend extends StatefulWidget {
  String? data;
  String userid;
  CompleteSend({super.key, required this.data, required this.userid});

  @override
  State<CompleteSend> createState() => _CompleteSendState();
}

class _CompleteSendState extends State<CompleteSend> {
  final _db = FirestoreService();
  final _amountController = TextEditingController();
  // final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complete Transfer"),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text("Complete transfer to N${widget.data!.split('-').first}"),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                    hintText: "Enter amount",
                  ),
                  validator: (val) {
                    if (val!.isNotEmpty) {
                      if (Constants.userDetails['balance'] < int.parse(val)) {
                        return "Insufficient Balance";
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text("Securely enter your pin"),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                    child: Pinput(
                  obscureText: true,
                  onCompleted: (value) async {
                    Fluttertoast.showToast(msg: value);
                    if (_formKey.currentState!.validate()) {
                      if (int.parse(Constants.userDetails['pin']) ==
                          int.parse(value)) {
                        await _db.sendFunds(widget.userid, _amountController.text,
                            widget.data!.split('-').first);
                      } else {
                        Fluttertoast.showToast(msg: "Pin Incorrect");
                      }
                    }
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
