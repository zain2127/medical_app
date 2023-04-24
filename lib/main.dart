import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Views/Authentication_Screen/Signin_Screen.dart';
import 'package:medical_app/Views/Layout_Screens/Bottom_Navigation_screen.dart';

bool isLoggedIn = false;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      isLoggedIn = true;
      runApp(const MyApp());
    } else {
      isLoggedIn = false;
      runApp(const MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryIconTheme: const IconThemeData(color: Colors.black)),
        home: (isLoggedIn)
            ? const BottomNavigationScreen()
            : const SignInScreen());
  }
}
