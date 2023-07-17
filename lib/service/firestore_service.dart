import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olupay/service/constants.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;

  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('user');

  final CollectionReference _transactionCollectionReference =
      FirebaseFirestore.instance.collection('transaction');

  Future saveUserDetails(userDataMap, uid, context) async {
    try {
      await _userCollectionReference.doc(uid).set(userDataMap);
    } catch (e) {
      // hideLoader(context);
      Fluttertoast.showToast(msg: e.toString());
      print(e.toString());
    }
  }

  Future getUserById(uid) async {
    return await _userCollectionReference.doc(uid).get();
  }

  Future updateUserById(uid, amount) async {
    await _userCollectionReference.doc(uid).update({"amount": amount});
  }

  Future<QuerySnapshot> getUserByUsername(username) async {
    return await _userCollectionReference
        .where("username", isEqualTo: username)
        .get();
  }

  Future sendFunds(uid, amount, username) async {
    try {
      // get creditor by username
      var creditor = await getUserByUsername(username);

      print(creditor.docs[0].get('email'));
      print(creditor.docs[0].id);
      var newbal = int.parse(creditor.docs[0].get('balance')) + int.parse(amount);

      // // create transaction
      Map<String, dynamic> debitTransaction = {
        "receiver": creditor.docs[0].get('username'),
        'amount': int.parse(amount),
        'date': DateTime.now().toUtc().toString()
      };
      Map<String, dynamic> creditTransaction = {
        "sender": "oludare",
        'amount': int.parse(amount),
        //dfsdf
        'date': DateTime.now().toUtc().toString()
      };
      await _transactionCollectionReference
          .doc(creditor.docs[0].id)
          .set(creditTransaction);
      await _transactionCollectionReference.doc(uid).set(debitTransaction);
      //update user balance
      var bal = int.parse(Constants.userDetails['balance']) - int.parse(amount);
     await updateUserById(uid, bal);
      // // update creditor balance
    await  updateUserById(creditor.docs[0].id, newbal);
      //credit balance
    } catch (e) {
      print('Error adding data to Firestore: $e');
    }
  }

  Stream getTransaction(uid) => _transactionCollectionReference
      .where("uid", isEqualTo: uid)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((event) => event.docs);
}
