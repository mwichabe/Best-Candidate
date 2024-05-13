import 'package:best_candidate/Dashboard/Payment/success.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MakeOrder extends StatefulWidget {
  const MakeOrder({Key? key}) : super(key: key);

  @override
  State<MakeOrder> createState() => _MakeOrderState();
}

class _MakeOrderState extends State<MakeOrder> {
  final _currentUser = FirebaseAuth.instance.currentUser;
  final _ordersCollection = FirebaseFirestore.instance.collection('users');
  final String _orderTupe = 'Online Portfolio';
  final String budget = '\$150';
  final String status = 'Reviewing';
  final String payment = 'Incomplete';
  bool _uploading = false;

  Future<void> _createOrder() async {
    try {
       setState(() {
        _uploading = true;
      });
      final userData = await _ordersCollection.doc(_currentUser!.uid).get();
      final userName = userData['userName'];
      final email = userData['email'];

      await _ordersCollection.doc(_currentUser.uid).collection('orders').add({
        'userName': userName,
        'email': email,
        'createdAt': Timestamp.now(),
        'Order Type':_orderTupe,
        'budget': budget,
        'status': status,
        'payment': payment
      });
      setState(() {
        _uploading = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Success()),
      );
    } catch (e) {
      print('Error creating order: $e');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirm'),
                      content: const Text('Are you sure you want to proceed?'),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await _createOrder();
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primarycolor,
              ),
              child: const Text(
                'Place your Order',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
