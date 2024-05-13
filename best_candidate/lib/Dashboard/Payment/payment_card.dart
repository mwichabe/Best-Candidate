import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final VoidCallback initiatePayment;
  final String text;
  const PaymentCard({super.key, required this.initiatePayment, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey,
      onTap: initiatePayment,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
          color: primarycolor,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child:Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,style: const TextStyle(color: Colors.white),),
          ),
        )
      ),
    );
  }
}