import 'package:best_candidate/Dashboard/BuildingCv/cvGenerator.dart';
import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart' show rootBundle;

class Final extends StatefulWidget {
  final String selectedPlan;
  Final({super.key, required this.selectedPlan});

  @override
  State<Final> createState() => _FinalState();
}

class _FinalState extends State<Final> with SingleTickerProviderStateMixin {
  User? user = FirebaseAuth.instance.currentUser;

  UserModelOne loggedInUser = UserModelOne(uid: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModelOne.fromMap(value.data());
      setState(() {});
    });
    _controller = AnimationController(vsync: this);
  }

  late AnimationController _controller;
  final currentUserId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedPlan == "Free"
        ? Scaffold(
            body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserId)
                .collection('freecvplan')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final resumeDoc = snapshot.data!.docs;
                if (resumeDoc.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'Please add details for your resume to be generated'),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            },
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Home'),
                              ),
                            )),
                      ],
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListView.builder(
                      itemCount: resumeDoc.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final resumes = resumeDoc[index];
                        final institutionName = resumes['institution'];
                        final category = resumes['category'];
                        final companyName = resumes['companyName'];
                        final jobTitle = resumes['jobTitle'];
                        final skills = resumes['skills'];
                        final startEndDate = resumes['startDate'];

                        return Container(
                          color: Colors.grey.shade100,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        radius: 30,
                                        child: ClipOval(
                                            child: Image.network(
                                                '${loggedInUser.profilePictureUrl}'))
                                        // NetworkImage('${loggedInUser.profilePictureUrl}'),
                                        ),
                                    Text(
                                      '${loggedInUser.firstName} \n ${loggedInUser.lastName}',
                                      style: const TextStyle(
                                          color: primarycolor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          letterSpacing: 1.5),
                                    ),
                                    const Spacer(),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          '${loggedInUser.email}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${loggedInUser.phoneNumber}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${loggedInUser.address}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                              fontSize: 12),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    jobTitle,
                                    style: const TextStyle(
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('${loggedInUser.bio}'),
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Professional Experience',
                                      style: TextStyle(
                                          color: primarycolor, fontSize: 18),
                                    )
                                  ],
                                ),
                                const Divider(
                                  color: primarycolor,
                                ),
                                Text(
                                    'Worked at $companyName, from $startEndDate, I was able to sharpen my skills in $skills. \n  The Working environment was favourable and had fair salary'),
                                const Divider(
                                  color: primarycolor,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Education',
                                      style: TextStyle(
                                          color: primarycolor, fontSize: 18),
                                    )
                                  ],
                                ),
                                Text(
                                  'Got a $category from',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  institutionName,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(
                                  color: primarycolor,
                                ),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Key Skills:',
                                      style: TextStyle(
                                          color: primarycolor, fontSize: 18),
                                    )
                                  ],
                                ),
                                Text(skills.toString()),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () => deleteResume(
                                          resumeDoc[index].reference),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.red),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Delete',
                                            style: TextStyle(
                                                color: primarycolor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home())),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Colors.green),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Home',
                                            style: TextStyle(
                                                color: primarycolor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          final Directory? directory;
                                          final image = pw.MemoryImage(
                                            (await rootBundle
                                                    .load(ConstanceData.logo))
                                                .buffer
                                                .asUint8List(),
                                          );
                                          try {
                                            final doc = pw.Document();
                                            doc.addPage(pw.Page(
                                                pageFormat: PdfPageFormat.a4,
                                                build: (pw.Context context) {
                                                  return pw.Container(
                                                    decoration:
                                                        pw.BoxDecoration(
                                                            color: PdfColor
                                                                .fromInt(Colors
                                                                    .grey
                                                                    .shade100
                                                                    .value),
                                                            border:
                                                                pw.Border.all(
                                                              color: PdfColor
                                                                  .fromInt(Colors
                                                                      .grey
                                                                      .value),
                                                            )),
                                                    child: pw.Padding(
                                                      padding: const pw
                                                          .EdgeInsets.all(8.0),
                                                      child: pw.Column(
                                                        children: [
                                                          pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              // NetworkImage('${loggedInUser.profilePictureUrl}'),

                                                              pw.Text(
                                                                '${loggedInUser.firstName} \n ${loggedInUser.lastName}',
                                                                style: pw.TextStyle(
                                                                    color: PdfColor.fromInt(Colors
                                                                        .green
                                                                        .value),
                                                                    fontWeight: pw
                                                                        .FontWeight
                                                                        .bold,
                                                                    fontSize:
                                                                        22,
                                                                    letterSpacing:
                                                                        1.5),
                                                              ),
                                                              pw.Spacer(),
                                                              pw.Column(
                                                                mainAxisAlignment: pw
                                                                    .MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  pw.Text(
                                                                    '${loggedInUser.email}',
                                                                    style: pw.TextStyle(
                                                                        fontWeight: pw
                                                                            .FontWeight
                                                                            .bold,
                                                                        color: PdfColor.fromInt(Colors
                                                                            .blue
                                                                            .value),
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  pw.Text(
                                                                    '${loggedInUser.phoneNumber}',
                                                                    style: pw.TextStyle(
                                                                        fontWeight: pw
                                                                            .FontWeight
                                                                            .bold,
                                                                        color: PdfColor.fromInt(Colors
                                                                            .blue
                                                                            .value),
                                                                        fontSize:
                                                                            12),
                                                                  ),
                                                                  pw.Text(
                                                                    '${loggedInUser.address}',
                                                                    style: pw.TextStyle(
                                                                        fontWeight: pw
                                                                            .FontWeight
                                                                            .bold,
                                                                        color: PdfColor.fromInt(Colors
                                                                            .blue
                                                                            .value),
                                                                        fontSize:
                                                                            12),
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          pw.SizedBox(
                                                            height: 20,
                                                          ),
                                                          pw.Padding(
                                                            padding: const pw
                                                                .EdgeInsets.all(
                                                                8.0),
                                                            child: pw.Text(
                                                              jobTitle,
                                                              style: const pw
                                                                  .TextStyle(
                                                                fontSize: 24,
                                                              ),
                                                            ),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 20,
                                                          ),
                                                          pw.Padding(
                                                            padding: const pw
                                                                .EdgeInsets.all(
                                                                8.0),
                                                            child: pw.Text(
                                                                '${loggedInUser.bio}',
                                                                style: const pw
                                                                    .TextStyle(
                                                                  letterSpacing:
                                                                      2.0,
                                                                  fontSize: 16,
                                                                )),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 20,
                                                          ),
                                                          pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'Professional Experience',
                                                                style: pw.TextStyle(
                                                                    color: PdfColor
                                                                        .fromInt(Colors
                                                                            .green
                                                                            .value),
                                                                    fontSize:
                                                                        18),
                                                              )
                                                            ],
                                                          ),
                                                          pw.SizedBox(
                                                            height: 15,
                                                          ),
                                                          pw.Divider(
                                                            color: PdfColor
                                                                .fromInt(Colors
                                                                    .green
                                                                    .value),
                                                          ),
                                                          pw.Text(
                                                              'Worked at $companyName, from $startEndDate, I was able to sharpen my skills in $skills. \n  The Working environment was favourable and had fair salary',
                                                              style: const pw
                                                                  .TextStyle(
                                                                  letterSpacing:
                                                                      2.0,
                                                                  fontSize:
                                                                      15)),
                                                          pw.Divider(
                                                            color: PdfColor
                                                                .fromInt(Colors
                                                                    .green
                                                                    .value),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 20,
                                                          ),
                                                          pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'Education',
                                                                style: pw.TextStyle(
                                                                    color: PdfColor
                                                                        .fromInt(Colors
                                                                            .green
                                                                            .value),
                                                                    fontSize:
                                                                        18),
                                                              )
                                                            ],
                                                          ),
                                                          pw.SizedBox(
                                                            height: 20,
                                                          ),
                                                          pw.Text(
                                                            'Got a $category from',
                                                            style: const pw
                                                                .TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                          pw.Text(
                                                            institutionName,
                                                            style: pw.TextStyle(
                                                                fontSize: 18,
                                                                fontWeight: pw
                                                                    .FontWeight
                                                                    .bold),
                                                          ),
                                                          pw.Divider(
                                                            color: PdfColor
                                                                .fromInt(Colors
                                                                    .green
                                                                    .value),
                                                          ),
                                                          pw.SizedBox(
                                                            height: 20,
                                                          ),
                                                          pw.Row(
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              pw.Text(
                                                                'Key Skills:',
                                                                style: pw.TextStyle(
                                                                    color: PdfColor
                                                                        .fromInt(Colors
                                                                            .green
                                                                            .value),
                                                                    fontSize:
                                                                        18),
                                                              )
                                                            ],
                                                          ),
                                                          pw.Container(
                                                            width:
                                                                double.infinity,
                                                            height: 70,
                                                            decoration: pw.BoxDecoration(
                                                                color: PdfColor
                                                                    .fromInt(Colors
                                                                        .blue
                                                                        .value),
                                                                borderRadius: const pw
                                                                    .BorderRadius.all(
                                                                    pw.Radius
                                                                        .circular(
                                                                            10))),
                                                            child: pw.Text(
                                                                skills
                                                                    .toString(),
                                                                style: pw.TextStyle(
                                                                    fontWeight: pw
                                                                        .FontWeight
                                                                        .bold,
                                                                    color: PdfColor
                                                                        .fromInt(Colors
                                                                            .white
                                                                            .value))),
                                                          ),
                                                          pw.SizedBox(
                                                              height: 10),
                                                          pw.Image(
                                                            image,
                                                            width: 70,
                                                            fit: pw
                                                                .BoxFit.contain,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }));

                                            if (Platform.isIOS) {
                                              directory =
                                                  await getApplicationDocumentsDirectory();
                                            } else {
                                              directory =
                                                  await getDownloadsDirectory();
                                            }

                                            if (directory == null) {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      'Document directory not available');
                                              return;
                                            }
                                            String path = directory.path;
                                            String myFile =
                                                '$path/myresume-${loggedInUser.userName}.pdf';
                                            final file = File(myFile);
                                            await file
                                                .writeAsBytes(await doc.save());
                                            OpenFile.open(myFile);
                                          } catch (e) {
                                            debugPrint("$e");
                                            Fluttertoast.showToast(msg: '$e');
                                          }
                                        },
                                        child: const Icon(Icons.download)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ))
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Generating CV using Gemini AI..."),
                  ElevatedButton(
                    onPressed: () async {
                      final cvGenerator = CVGenerator();
                      final cv = await cvGenerator.generateCV(
                        '${loggedInUser.firstName} ${loggedInUser.lastName}',
                        loggedInUser.email ?? '',
                        loggedInUser.phoneNumber ?? '',
                        loggedInUser.bio ?? '',
                        'Bachelor of Science in Computer Science',
                        '5 years of experience in software development',
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scaffold(
                            appBar: AppBar(
                              title: const Text('Generated CV'),
                            ),
                            body: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text(cv),
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text('Generate CV'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                    child: const Text('Home'),
                  ),
                ],
              ),
            ),
          );
  }

  void deleteResume(DocumentReference requestRef) {
    requestRef.delete().then((value) {
      Fluttertoast.showToast(msg: 'Resume Deleted');
      print('Deleted');
    }).catchError((error) {
      Fluttertoast.showToast(msg: 'Error deleting resume: $error');
      print('Error deleting resume: $error');
    });
  }
}
