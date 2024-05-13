import 'package:best_candidate/Dashboard/Payment/make_order.dart';
import 'package:best_candidate/Dashboard/Payment/payment.dart';
import 'package:flutter/material.dart';

class PortfolioDialog extends StatefulWidget {
  const PortfolioDialog({Key? key}) : super(key: key);

  @override
  _PortfolioDialogState createState() => _PortfolioDialogState();
}

class _PortfolioDialogState extends State<PortfolioDialog> {
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Terms of Payment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'By continuing, you agree to the terms and conditions of use.45 \n \n 1. Upon order completion online profile generation starts. \n 2. Total price is \$70 . \n 3.A deposit of \$35 will initiate your profile creation. \n 4. Final product will be delivered to you on the 7th day.\n 5. There is no refund of \$ 35 upon order cancellation midway.',
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Checkbox(
                value: _termsAccepted,
                onChanged: (value) {
                  setState(() {
                    _termsAccepted = value!;
                  });
                },
              ),
              const Text('I agree '),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: _termsAccepted
              ? () {
                  Navigator.of(context).pop(); 
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MakeOrder()));
                }
              : null,
          child: const Text('Continue'),
        ),
      ],
    );
  }
}