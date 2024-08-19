import 'package:best_candidate/Dashboard/BuildingCv/final.dart';
import 'package:best_candidate/Dashboard/BuildingCv/resume.dart';
import 'package:flutter/material.dart';

class PlanSelectionDialog extends StatefulWidget {
  @override
  _PlanSelectionDialogState createState() => _PlanSelectionDialogState();
}

class _PlanSelectionDialogState extends State<PlanSelectionDialog> {
  String _selectedPlan = 'Free';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Choose Your Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('Free'),
            leading: Radio(
              value: 'Free',
              groupValue: _selectedPlan,
              onChanged: (value) {
                setState(() {
                  _selectedPlan = value.toString();
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Premium'),
            leading: Radio(
              value: 'Premium',
              groupValue: _selectedPlan,
              onChanged: (value) {
                setState(() {
                  _selectedPlan = value.toString();
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            print('Selected plan: $_selectedPlan');
            _selectedPlan == "Free"
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Resume(
                              selectedPlan: _selectedPlan,
                            ))))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => Final(
                              selectedPlan: _selectedPlan,
                            ))));
          },
          child: const Text('Select'),
        ),
      ],
    );
  }
}
