import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class PremiumTemplate extends StatelessWidget {
  final String path;
  final String number;
  const PremiumTemplate({super.key, required this.path, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          children: [
            Container(
              child: Image.asset(
                path,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                top: 7,
                left: 3,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: primarycolor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      number,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 7),
                    ),
                  ),
                ))
          ],
        ),
        ElevatedButton(
            onPressed: () {
              Fluttertoast.showToast(msg: "Order Placed Successfully");
              whatsApp();
            },
            child: Text("Get this CV"))
      ],
    );
  }

  whatsApp() {
    return launchUrl(
      Uri.parse(
        'whatsapp://send?phone=+254704858069+&text=Hello, I  want a my resume to be similar to sample number $number'
        ', The price is \$ 1.55',
      ),
    );
  }
}
