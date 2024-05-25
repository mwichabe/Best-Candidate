import 'package:best_candidate/constance/constance.dart';
import 'package:flutter/material.dart';

class OurTextFormField extends StatelessWidget {
  final String label;
  final bool pasVisible;
  final TextEditingController controller;
  final String validatorText;
  final String regEx;
  final String regExValidatorText;
  final TextInputType keyboardType;
  final IconData iconData;
  final bool isBio;
  const OurTextFormField(
      {super.key,
      required this.label,
      required this.pasVisible,
      required this.controller,
      required this.validatorText,
      required this.regEx,
      required this.regExValidatorText,
      required this.keyboardType,
      required this.iconData,
      required this.isBio});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            maxLength: isBio == true ? 300 : null,
            minLines: isBio == true ? 2 : null,
            maxLines: isBio == true ? null : 1,
            obscureText: pasVisible,
            style: const TextStyle(color: Colors.white),
            keyboardType: keyboardType,
            controller: controller,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.isEmpty) {
                return (validatorText);
              }
              //regEx for email
              if (!RegExp(regEx).hasMatch(value)) {
                return (regExValidatorText);
              }
              return null;
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hoverColor: Colors.white,
              labelText: label,
              labelStyle: const TextStyle(color: blueColor),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              prefixIcon: Align(
                widthFactor: 1.0,
                heightFactor: 1.0,
                child: Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          isBio == true
              ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                      valueListenable: controller,
                      builder: (context, value, child) {
                        int characterCount = value.text.length;
                        return Text(
                          '$characterCount/150',
                          style: const TextStyle(fontSize: 12, color: primarycolor,fontWeight: FontWeight.w700),
                        );
                      },
                    ),
                ],
              )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
