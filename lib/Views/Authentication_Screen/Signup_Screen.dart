import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medical_app/Views/Authentication_Screen/Signin_Screen.dart';

import '../../Utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
  signup() {
    setState(() {
      loading = true;
    });
    _auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text)
        .then((value) {
      Utils().successMessage("Account created");
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => const SignInScreen()));
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
            const Center(child: Text('Sign Up to our \n Medical App',
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
                  signup();
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
                    child: const Text('Login',
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

