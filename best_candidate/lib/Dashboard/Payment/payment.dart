import 'package:best_candidate/Dashboard/Payment/payment_card.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool _loading = false;

  Future<void> lipaNaMpesa() async {
    setState(() {
      _loading = true;
    });

    try {
      dynamic transactionInitialisation;
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          //7700 
          amount: 1.0,
          partyA: "254704858069",
          partyB: "174379",
          callBackURL:
              Uri(scheme: "https", host: "mpesa-requestbin.herokuapp.com", path: "/1hhy6391"),
          accountReference: "Collins Best Candidate",
          phoneNumber: "254704858069",
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey: ConstanceData.testCredentials);
      setState(() {
        _loading = false;
      });

      // Handle the transaction initialization response here
      print("Transaction Initialization Response: $transactionInitialisation");
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Payment Method',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: primarycolor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PaymentCard(
                text:'Paypal',
                initiatePayment: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PaymentCard(
                text: 'Mpesa',
                initiatePayment: () {
                  lipaNaMpesa();
                },
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(8.0),
              child: PaymentCard(
                text: 'Cancel',
                initiatePayment: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
