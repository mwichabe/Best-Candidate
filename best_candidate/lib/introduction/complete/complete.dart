import 'dart:io';
import 'package:best_candidate/Dashboard/home.dart';
import 'package:best_candidate/constance/constance.dart';
import 'package:best_candidate/introduction/widgets/our_text_field.dart';
import 'package:best_candidate/models/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class CompleteSetup extends StatefulWidget {
  const CompleteSetup({super.key});

  @override
  State<CompleteSetup> createState() => _CompleteSetupState();
}

class _CompleteSetupState extends State<CompleteSetup> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;

  UserModelOne loggedInUser = UserModelOne(uid: '');
  bool isImageSelected = false;

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
  }

  //pick image
  File? _image;
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        isImageSelected = true;
      });
    }
    print('$_image');
  }

  //controllers
  final TextEditingController _skillsEditingController = TextEditingController();
  final TextEditingController _bioEditingController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool canPop = false;
    return PopScope(
       canPop: canPop,
      onPopInvoked: (bool value) {
        setState(() {
          canPop= !value;
        });

        if (canPop) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Click once more to exit"),
              duration: Duration(milliseconds: 1500),
            ),
          );
        }
      },
      child: Scaffold(body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ConstanceData.splashBg),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                60,
                20,
                40,
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(2, 2, 10, 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Complete Your Profile',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 64,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: SizedBox(
                              height: 180,
                              width: 180,
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.fill,
                                      height: 180,
                                      width: 180,
                                    )
                                  : Image.network(
                                      loggedInUser.profilePictureUrl ??
                                          '',
                                      fit: BoxFit.cover,
                                      width: 140,
                                      height: 140,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error),
                                    )),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: _pickImage,
                            icon: const CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black,
                              ),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person_2_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${loggedInUser.userName}',
                        style: const TextStyle(color: blueColor),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${loggedInUser.phoneNumber}',
                        style: const TextStyle(color: blueColor),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          OurTextFormField(label: 'Skills e.g if software provide languages', pasVisible: false, controller: _skillsEditingController, validatorText: 'Field required', regEx: '', regExValidatorText: '', keyboardType: TextInputType.text, iconData: Icons.ac_unit, isBio: false,),
                          const SizedBox(
                            height: 10,
                          ),
                          OurTextFormField(label: 'Bio, What are you good at? It will be on your CV Market Yourself', pasVisible: false, controller: _bioEditingController, validatorText: 'Field Required', regEx: '', regExValidatorText: '', keyboardType: TextInputType.text, iconData: Icons.person, isBio: true,),
                          const SizedBox(
                            height: 10,
                          ),
                          OurTextFormField(label: 'Address', pasVisible: false, controller: _addressController, validatorText: 'Field Required', regEx: '', regExValidatorText: '', keyboardType: TextInputType.text, iconData: Icons.location_on, isBio: false,),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      )),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            String UniqueFileName =
                                DateTime.now().millisecond.toString();
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();
                            Reference referenceDirImage =
                                referenceRoot.child('images');
                            Reference referenceImageToUpload =
                                referenceDirImage.child(UniqueFileName);
                            try {
                              await referenceImageToUpload.putFile(_image!);
                              String imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                              loggedInUser.profilePictureUrl = imageUrl;
                              loggedInUser.skills =
                                  _skillsEditingController.text;
                              loggedInUser.bio =
                                  _bioEditingController.text;
                              loggedInUser.address =
                                  _addressController.text;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user!.uid)
                                  .update(loggedInUser.toMap());
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                              Fluttertoast.showToast(
                                msg:
                                    'Profile photo and information updated successfully',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.green,
                                timeInSecForIosWeb: 1,
                                fontSize: 16,
                              );
                            } catch (err) {
                              Fluttertoast.showToast(
                                  msg:
                                      'No image selected, please update your profile photo.');
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  'Unable to upload your data Please fill the required fields',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              timeInSecForIosWeb: 1,
                              fontSize: 16,
                            );
                            //Fluttertoast.showToast(msg: 'No image selected, please update your profile photo.');
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blueColor,
                        ),
                        child: const Text(
                          'SAVE',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      if (isLoading) const CircularProgressIndicator(),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      })),
    );
  }
}