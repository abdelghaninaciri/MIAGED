import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:miaged/screens/home_screen.dart';
import 'package:miaged/screens/profil.dart';
import 'package:miaged/screens/signin_screen.dart';
import 'package:miaged/screens/chercher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCwl1LYxZvlpZsyfb7vVBLm9l8-TdpOkOM",
      appId: "1:1075997654253:android:75370b579d2f47b5eb60e4",
      messagingSenderId: "1075997654253",
      projectId: "miaged-fa264",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/profil": (context) => ProfilPage(),
        "/chercher": (context) => const ChercherPage(),
        "/liste_vetement": (context) => const HomeScreen(),
      },
      title: 'MIAGED',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const SignInScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(),
    );
  }
}
