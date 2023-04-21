import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/Views/Authentication_Screen/Signup_Screen.dart';
import 'package:medical_app/Views/Layout_Screens/Bottom_Navigation_screen.dart';

import '../../Utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  login() {
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((value) {
          Utils().successMessage("Login Successful");
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const BottomNavigationScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().errorMessage(error.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(child: Text('Sign in to our \n Medical App',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
            const SizedBox(height: 20,),
            Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email', prefixIcon: Icon(FontAwesomeIcons.envelope)
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty)
                          {
                            return 'Enter email';
                          }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Password',
                          prefixIcon: Icon(FontAwesomeIcons.lock)

                      ),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                  ],
                )
            ),
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                if(formKey.currentState!.validate())
                  {
                    login();
                  }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.blue.shade400
                ),
                child: const Center(
                    child: Text('Login',
                      style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),)),
              ),
            ),
            const SizedBox(height: 5,),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text('Forgot Password?',
                    style: TextStyle(decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),)),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    FontAwesomeIcons.google, size: 30, color: Colors.red,),
                ),
                SizedBox(width: 12,),
                CircleAvatar(
                  radius: 30,
                  child: Icon(FontAwesomeIcons.phone, size: 30,),
                )
              ],
            ),
            const SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?", style: TextStyle(fontSize: 16),),
                const SizedBox(width: 4.0,),
                InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const SignupScreen()));
                    },
                    child: const Text('Signup',
                        style: TextStyle(decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 16))),
              ],
            )

          ],
        ),
      ),
    );
  }
}

