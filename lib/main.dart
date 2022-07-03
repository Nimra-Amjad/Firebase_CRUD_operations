import 'package:firebase_demo/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // ignore: prefer_const_constructors
    options: FirebaseOptions(
        apiKey: "",
        appId: "",
        messagingSenderId: "",
        projectId: "crud-operations-525b7"),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Firestore CRUD',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const HomePage(),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
