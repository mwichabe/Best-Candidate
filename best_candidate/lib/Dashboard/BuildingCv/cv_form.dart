import 'dart:async';

import 'package:best_candidate/Dashboard/BuildingCv/final.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdditionalForm extends StatefulWidget {
  final String selectedPlan;
  const AdditionalForm({super.key, required this.selectedPlan});

  @override
  State<AdditionalForm> createState() => _AdditionalFormState();
}

class _AdditionalFormState extends State<AdditionalForm> {
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();
  final institution = TextEditingController();
  final category = TextEditingController();
  final companyName = TextEditingController();
  final jobTitle = TextEditingController();
  final startDate = TextEditingController();
  final skills = <String>[]; 


  // Function to add a new skill
  void addSkill(String newSkill) {
    setState(() {
      skills.add(newSkill);
    });
  }

  // Function to remove a skill
  void removeSkill(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      color: lightGreyColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Educational Background
                const Text('Educational Background'),
                TextFormField(
                  controller: institution,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    focusColor: primarycolor,
                      labelText: 'Institution Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter institution name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: category,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    focusColor: primarycolor,
                      labelText: 'Degree/Diploma/Cert',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter degree/diploma/Cert';
                    }
                    return null;
                  },
                ),
                const Divider(),
        
                // Profession Experience (can be repeated for multiple entries)
                const Text('Profession Experience'),
                _ExperienceEntry(companyName, jobTitle, startDate),
                const SizedBox(
                  height: 16,
                ),
                // Skills Section
                const Text('Skills'),
                Wrap(
                  children: [
                    for (var skill in skills)
                      Chip(
                        label: Text(skill),
                        onDeleted: () => removeSkill(skills.indexOf(skill)),
                      ),
                    // Add a button or text field to allow user to add new skills
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: lightGreyColor
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => _addSkillDialog(context),
                        );
                      },
                      child: const Text('Add Skill',style: TextStyle(color: primarycolor),),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        backgroundColor: lightGreyColor
                      ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Save data to Firestore
                      final userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(currentUserId);
                      final freeCvPlan = userDoc.collection('freecvplan').doc();
        
                      await freeCvPlan.set({
                        'institution': institution.text,
                        'category': category.text,
                        'companyName': companyName.text,
                        'jobTitle': jobTitle.text,
                        'startDate': startDate.text,
                        'skills': skills,
                      });
        
                      // Show success message or navigate to a different screen
                      Fluttertoast.showToast(
                        msg: 'Data Saved successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        timeInSecForIosWeb: 1,
                        fontSize: 16,
                      );
        
                      institution.text = '';
                      category.text = '';
                      companyName.text = '';
                      jobTitle.text = '';
                      startDate.text = '';
                      skills.clear();
                    }
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Final(selectedPlan: widget.selectedPlan)));
                  },
                  child: const Text('Save and Generate',style: TextStyle(color: primarycolor),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addSkillDialog(BuildContext context) {
    final currentSkill = TextEditingController();
    return AlertDialog(
      title: TextFormField(
        
        controller: currentSkill,
        decoration: const InputDecoration(labelText: 'Enter Skill',
        focusColor: primarycolor,
        ),
        
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newSkill = currentSkill.text.trim();
            if (newSkill.isNotEmpty) {
              addSkill(newSkill);
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class _ExperienceEntry extends StatelessWidget {
  final TextEditingController companyName;
  final TextEditingController jobTitle;
  final TextEditingController startDate;

  const _ExperienceEntry(this.companyName, this.jobTitle, this.startDate);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          textInputAction: TextInputAction.next,
          controller: companyName,
          validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Company name';
                  }
                  return null;
                },
          decoration: const InputDecoration(
            focusColor: primarycolor,
              labelText: 'Company Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Job Title';
                  }
                  return null;
                },
          textInputAction: TextInputAction.next,
          controller: jobTitle,
          decoration: const InputDecoration(
            focusColor: primarycolor,
              labelText: 'Job Title',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          textInputAction: TextInputAction.done,
          validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your dates';
                  }
                  return null;
                },
          controller: startDate,
          decoration: const InputDecoration(
            focusColor: primarycolor,
              labelText: 'Start Date - End Date (e.g., YYYY-MM-DD)',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
      ],
    );
  }
}
