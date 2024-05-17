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
      title: Text('Choose Your Plan'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Free'),
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
            title: Text('Premium'),
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
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Do something with the selected plan
            print('Selected plan: $_selectedPlan');
            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => Resume(selectedPlan: _selectedPlan,))));
          },
          child: Text('Select'),
        ),
      ],
    );
  }
}