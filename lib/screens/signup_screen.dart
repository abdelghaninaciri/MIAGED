import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/reusable_widgets/reusable_widget.dart';
import 'package:miaged/screens/home_screen.dart';
import 'package:miaged/utils/color_utils.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  final _userNameTextController = TextEditingController();
  final _dateNaissanceTextController = TextEditingController();
  final _villeTextController = TextEditingController();
  final _codePostalTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("S’inscrire",),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("128874"),
                hexStringToColor("128874"),
                hexStringToColor("128874")
              ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Entrer UserName", Icons.person, false,
                        _userNameTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Entrer Date de naissance", Icons.date_range, false,
                        _dateNaissanceTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Entrer la Ville", Icons.location_city_outlined, false,
                        _villeTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Entrer le Code Postal", Icons.reduce_capacity_outlined, false,
                        _codePostalTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Entrer Email Id", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Entrer Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                              .then((value) {
                            print("Created New Account");
                            Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                          }).onError((error, stackTrace) {
                            showDialog(context: context,
                                builder: (context) {
                                  return AlertDialog(title :Text("Veuillez réessayer"),);
                                });
                            print("Error ${error.toString()}");
                          });
                          FirebaseFirestore.instance.collection('Users').add({
                            'nom': _userNameTextController.value.text,
                            'age': _dateNaissanceTextController.value.text,
                            'ville': _villeTextController.value.text,
                            'code_postal': _codePostalTextController.value.text,
                            'email': _emailTextController.value.text,
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Ajouter')),
                  ],
                ),
              ))),
    );
  }
}

