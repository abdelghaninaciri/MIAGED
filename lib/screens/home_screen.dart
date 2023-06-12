import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:miaged/drawer.dart';

import 'add_vetement_page.dart';
import '../utils/color_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text('Liste de vêtements'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            hexStringToColor("193c26"),
            hexStringToColor("193c26"),
            hexStringToColor("193c26")
          ], begin: Alignment.centerRight, end: Alignment.centerLeft)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return const AddPage();
              },
              fullscreenDialog: true,
            ));
          },
        ),
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
        child: const VetementsInformation(),
      ),
    );
  }
}

class VetementsInformation extends StatefulWidget {
  const VetementsInformation({Key? key}) : super(key: key);

  @override
  State<VetementsInformation> createState() => _VetementsInformationState();
}

class _VetementsInformationState extends State<VetementsInformation> {
  final Stream<QuerySnapshot> _vetementsStream =
      FirebaseFirestore.instance.collection('Vêtements').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _vetementsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> vetement =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.network(vetement['image']),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                vetement['titre'],
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Marque : '),
                              Text(vetement['marque'].toString()),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Prix : '),
                              Text(vetement['prix'].toString()),
                              const Text(' €'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('Taille : '),
                              Text(vetement['taille'].toString()),
                            ],
                          ),
                          Row(
                            children: [
                              for (final categorie in vetement['categories'])
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Chip(
                                      backgroundColor: Colors.blueGrey,
                                      label: Text(categorie)),
                                )
                            ],
                          ),
                          Row(children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ])
                        ],
                      ))
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
